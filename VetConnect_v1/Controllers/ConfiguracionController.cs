using System;
using Microsoft.AspNetCore.Mvc;
using VetConnect_v1.Models;
using Microsoft.EntityFrameworkCore;
using VetConnect_v1.Data;

namespace VetConnect_v1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ConfiguracionController : ControllerBase
    {
        private readonly VeterinariaDbContext _context;

        public ConfiguracionController(VeterinariaDbContext context)
        {
            _context = context;
        }

        // GET: api/Configuracion
        [HttpGet]
        public async Task<IActionResult> GetConfiguraciones()
        {
            var configuraciones = await _context.Configuraciones.ToListAsync();
            return Ok(configuraciones);
        }

        // GET: api/Configuracion/{id}
        [HttpGet("{id}")]
        public async Task<IActionResult> GetConfiguracionById(int id)
        {
            var configuracion = await _context.Configuraciones.FindAsync(id);
            if (configuracion == null)
                return NotFound($"Configuración con ID {id} no encontrada");

            return Ok(configuracion);
        }

        // POST: api/Configuracion
        [HttpPost]
        public async Task<IActionResult> CreateConfiguracion([FromBody] Configuracion configuracion)
        {
            if (configuracion == null)
                return BadRequest("La configuración es inválida");

            _context.Configuraciones.Add(configuracion);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(GetConfiguracionById), new { id = configuracion.ConfiguracionId }, configuracion);
        }

        // PUT: api/Configuracion/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateConfiguracion(int id, [FromBody] Configuracion configuracion)
        {
            if (id != configuracion.ConfiguracionId)
                return BadRequest("El ID de la configuración no coincide");

            _context.Entry(configuracion).State = EntityState.Modified;
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ConfiguracionExists(id))
                    return NotFound($"Configuración con ID {id} no encontrada");
                else
                    throw;
            }

            return NoContent();
        }

        // DELETE: api/Configuracion/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteConfiguracion(int id)
        {
            var configuracion = await _context.Configuraciones.FindAsync(id);
            if (configuracion == null)
                return NotFound($"Configuración con ID {id} no encontrada");

            _context.Configuraciones.Remove(configuracion);
            await _context.SaveChangesAsync();
            return Ok($"Configuración con ID {id} eliminada exitosamente");
        }

        private bool ConfiguracionExists(int id)
        {
            return _context.Configuraciones.Any(e => e.ConfiguracionId == id);
        }
    }
}
