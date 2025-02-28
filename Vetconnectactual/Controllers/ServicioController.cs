using Microsoft.AspNetCore.Mvc;
using VetConnect_v1.Data;
using VetConnect_v1.Models;
using Microsoft.EntityFrameworkCore;

namespace VetConnect_v1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ServicioController : ControllerBase
    {
        private readonly VeterinariaDbContext _context;

        public ServicioController(VeterinariaDbContext context)
        {
            _context = context;
        }

        // GET: api/Servicio
        [HttpGet]
        public async Task<IActionResult> GetServicios()
        {
            var servicios = await _context.Servicios.ToListAsync();
            return Ok(servicios);
        }

        // GET: api/Servicio/{id}
        [HttpGet("{id}")]
        public async Task<IActionResult> GetServicioById(int id)
        {
            var servicio = await _context.Servicios.FindAsync(id);
            if (servicio == null)
                return NotFound($"Servicio con ID {id} no encontrado");

            return Ok(servicio);
        }

        // POST: api/Servicio
        [HttpPost]
        public async Task<IActionResult> CreateServicio([FromBody] Servicio servicio)
        {
            if (servicio == null)
                return BadRequest("El servicio es inválido");

            _context.Servicios.Add(servicio);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(GetServicioById), new { id = servicio.ServicioId }, servicio);
        }

        // PUT: api/Servicio/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateServicio(int id, [FromBody] Servicio servicio)
        {
            if (id != servicio.ServicioId)
                return BadRequest("El ID del servicio no coincide");

            _context.Entry(servicio).State = EntityState.Modified;
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ServicioExists(id))
                    return NotFound($"Servicio con ID {id} no encontrado");
                else
                    throw;
            }

            return NoContent();
        }

        // DELETE: api/Servicio/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteServicio(int id)
        {
            var servicio = await _context.Servicios.FindAsync(id);
            if (servicio == null)
                return NotFound($"Servicio con ID {id} no encontrado");

            _context.Servicios.Remove(servicio);
            await _context.SaveChangesAsync();
            return Ok($"Servicio con ID {id} eliminado exitosamente");
        }

        private bool ServicioExists(int id)
        {
            return _context.Servicios.Any(e => e.ServicioId == id);
        }
    }
}
