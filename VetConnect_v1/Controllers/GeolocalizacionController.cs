using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using VetConnect_v1.Models;
using VetConnect_v1.Data;

namespace VetConnect_v1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class GeolocalizacionController : ControllerBase
    {
        private readonly VeterinariaDbContext _context;

        public GeolocalizacionController(VeterinariaDbContext context)
        {
            _context = context;
        }

        // GET: api/Geolocalizacion
        [HttpGet]
        public async Task<IActionResult> GetGeolocalizaciones()
        {
            var geolocalizaciones = await _context.Geolocalizaciones.ToListAsync();
            return Ok(geolocalizaciones);
        }

        // GET: api/Geolocalizacion/{id}
        [HttpGet("{id}")]
        public async Task<IActionResult> GetGeolocalizacionById(string id) // Ya usa string
        {
            var geolocalizacion = await _context.Geolocalizaciones.FindAsync(id);
            if (geolocalizacion == null)
                return NotFound($"Ubicación con ID {id} no encontrada");

            return Ok(geolocalizacion);
        }

        // POST: api/Geolocalizacion
        [HttpPost]
        public async Task<IActionResult> CreateGeolocalizacion([FromBody] Geolocalizacion geolocalizacion)
        {
            if (geolocalizacion == null)
                return BadRequest("La geolocalización es inválida");

            _context.Geolocalizaciones.Add(geolocalizacion);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(GetGeolocalizacionById), new { id = geolocalizacion.GeolocalizacionId }, geolocalizacion);
        }

        // PUT: api/Geolocalizacion/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateGeolocalizacion(string id, [FromBody] Geolocalizacion geolocalizacion) // Ya usa string
        {
            if (id != geolocalizacion.GeolocalizacionId)
                return BadRequest("El ID de la geolocalización no coincide");

            _context.Entry(geolocalizacion).State = EntityState.Modified;
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!GeolocalizacionExists(id))
                    return NotFound($"Ubicación con ID {id} no encontrada");
                else
                    throw;
            }

            return NoContent();
        }

        // DELETE: api/Geolocalizacion/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteGeolocalizacion(string id) // Ya usa string
        {
            var geolocalizacion = await _context.Geolocalizaciones.FindAsync(id);
            if (geolocalizacion == null)
                return NotFound($"Ubicación con ID {id} no encontrada");

            _context.Geolocalizaciones.Remove(geolocalizacion);
            await _context.SaveChangesAsync();
            return Ok($"Ubicación con ID {id} eliminada exitosamente");
        }

        private bool GeolocalizacionExists(string id) // Ya usa string
        {
            return _context.Geolocalizaciones.Any(e => e.GeolocalizacionId == id);
        }
    }
}