using System;
using Microsoft.AspNetCore.Mvc;
using VetConnect_v1.Models;
using Microsoft.EntityFrameworkCore;
using VetConnect_v1.Data;

namespace VetConnect_v1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TicketSoporteController : ControllerBase
    {
        private readonly VeterinariaDbContext _context;

        public TicketSoporteController(VeterinariaDbContext context)
        {
            _context = context;
        }

        // GET: api/TicketSoporte
        [HttpGet]
        public async Task<IActionResult> GetTickets()
        {
            try
            {
                var tickets = await _context.TicketSoporte.Include(t => t.Usuario).ToListAsync();
                if (tickets == null || !tickets.Any())
                    return NotFound("No se encontraron tickets.");

                return Ok(tickets);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error al obtener tickets: {ex.Message}");
                return StatusCode(500, "Hubo un problema al obtener los tickets.");
            }
        }

        // GET: api/TicketSoporte/{id}
        [HttpGet("{id}")]
        public async Task<IActionResult> GetTicketById(int id)
        {
            try
            {
                var ticket = await _context.TicketSoporte.Include(t => t.Usuario)
                    .FirstOrDefaultAsync(t => t.TicketId == id);
                if (ticket == null)
                    return NotFound($"Ticket con ID {id} no encontrado.");

                return Ok(ticket);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error al obtener el ticket con ID {id}: {ex.Message}");
                return StatusCode(500, "Hubo un problema al obtener el ticket.");
            }
        }

        // POST: api/TicketSoporte
        [HttpPost]
        public async Task<IActionResult> CreateTicket([FromBody] TicketSoporte ticket)
        {
            if (ticket == null)
                return BadRequest("El ticket es inválido.");

            try
            {
                var usuario = await _context.Usuarios.FindAsync(ticket.UsuarioId);
                if (usuario == null)
                    return BadRequest($"Usuario con ID {ticket.UsuarioId} no encontrado.");

                if (!ModelState.IsValid)
                    return BadRequest("Modelo inválido.");

                _context.TicketSoporte.Add(ticket);
                await _context.SaveChangesAsync();
                return CreatedAtAction(nameof(GetTicketById), new { id = ticket.TicketId }, ticket);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error al crear el ticket: {ex.Message}");
                return StatusCode(500, "Hubo un problema al crear el ticket.");
            }
        }

        // PUT: api/TicketSoporte/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateTicket(int id, [FromBody] TicketSoporte ticket)
        {
            if (id != ticket.TicketId)
                return BadRequest("El ID del ticket no coincide.");

            try
            {
                var existingTicket = await _context.TicketSoporte.FindAsync(id);
                if (existingTicket == null)
                    return NotFound($"Ticket con ID {id} no encontrado.");

                _context.Entry(ticket).State = EntityState.Modified;
                await _context.SaveChangesAsync();
                return NoContent();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!TicketSoporteExists(id))
                    return NotFound($"Ticket con ID {id} no encontrado.");
                else
                    throw;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error al actualizar el ticket con ID {id}: {ex.Message}");
                return StatusCode(500, "Hubo un problema al actualizar el ticket.");
            }
        }

        // DELETE: api/TicketSoporte/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTicket(int id)
        {
            try
            {
                var ticket = await _context.TicketSoporte.FindAsync(id);
                if (ticket == null)
                    return NotFound($"Ticket con ID {id} no encontrado.");

                _context.TicketSoporte.Remove(ticket);
                await _context.SaveChangesAsync();
                return Ok($"Ticket con ID {id} eliminado exitosamente.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error al eliminar el ticket con ID {id}: {ex.Message}");
                return StatusCode(500, "Hubo un problema al eliminar el ticket.");
            }
        }

        private bool TicketSoporteExists(int id)
        {
            return _context.TicketSoporte.Any(e => e.TicketId == id);
        }
    }
}
