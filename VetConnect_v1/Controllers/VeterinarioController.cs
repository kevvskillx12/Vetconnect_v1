using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using VetConnect_v1.Models;
using VetConnect_v1.Data;
using AutoMapper;
using VetConnect_v1.DTOs;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace VetConnect_v1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class VeterinarioController : ControllerBase
    {
        private readonly VeterinariaDbContext _context;
        private readonly IMapper _mapper; // Inyectar AutoMapper

        public VeterinarioController(VeterinariaDbContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        // GET: api/Veterinario
        [HttpGet]
        public async Task<IActionResult> GetVeterinarios()
        {
            var veterinarios = await _context.Veterinarios.ToListAsync();
            // Convertir a VeterinarioDto usando AutoMapper
            var veterinariosDto = _mapper.Map<List<VeterinarioDto>>(veterinarios);
            return Ok(veterinariosDto);
        }

        // GET: api/Veterinario/{id}
        [HttpGet("{id}")]
        public async Task<IActionResult> GetVeterinarioById(string id)
        {
            var veterinario = await _context.Veterinarios.FirstOrDefaultAsync(v => v.VeterinarioId == id);

            if (veterinario == null)
                return NotFound($"Veterinario con ID {id} no encontrado");

            // Convertir a VeterinarioDto usando AutoMapper
            var veterinarioDto = _mapper.Map<VeterinarioDto>(veterinario);
            return Ok(veterinarioDto);
        }

        // POST: api/Veterinario
        [HttpPost]
        public async Task<IActionResult> CreateVeterinario([FromBody] Veterinario veterinario)
        {
            if (veterinario == null)
                return BadRequest("El veterinario es inválido");

            // Validar que HorarioAtencion y Contacto sean números válidos
            if (!int.TryParse(veterinario.HorarioAtencion.ToString(), out _))
                return BadRequest("El horario de atención debe ser un número válido.");

            if (!int.TryParse(veterinario.Contacto.ToString(), out _))
                return BadRequest("El contacto debe ser un número válido.");

            _context.Veterinarios.Add(veterinario);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(GetVeterinarioById), new { id = veterinario.VeterinarioId }, veterinario);
        }

        // PUT: api/Veterinario/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateVeterinario(string id, [FromBody] Veterinario veterinario)
        {
            if (id != veterinario.VeterinarioId)
                return BadRequest("El ID del veterinario no coincide");

            // Validar que HorarioAtencion y Contacto sean números válidos
            if (!int.TryParse(veterinario.HorarioAtencion.ToString(), out _))
                return BadRequest("El horario de atención debe ser un número válido.");

            if (!int.TryParse(veterinario.Contacto.ToString(), out _))
                return BadRequest("El contacto debe ser un número válido.");

            _context.Entry(veterinario).State = EntityState.Modified;
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!VeterinarioExists(id))
                    return NotFound($"Veterinario con ID {id} no encontrado");
                else
                    throw;
            }

            return NoContent();
        }

        // DELETE: api/Veterinario/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteVeterinario(string id)
        {
            var veterinario = await _context.Veterinarios.FindAsync(id);
            if (veterinario == null)
                return NotFound($"Veterinario con ID {id} no encontrado");

            _context.Veterinarios.Remove(veterinario);
            await _context.SaveChangesAsync();
            return Ok($"Veterinario con ID {id} eliminado exitosamente");
        }

        private bool VeterinarioExists(string id)
        {
            return _context.Veterinarios.Any(e => e.VeterinarioId == id);
        }
    }
}
