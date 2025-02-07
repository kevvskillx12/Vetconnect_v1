using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using AutoMapper;
using VetConnect_v1.Data;
using VetConnect_v1.Models;
using VetConnect_v1.DTOs;

namespace VetConnect_v1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class MascotaController : ControllerBase
    {
        private readonly VeterinariaDbContext _context;
        private readonly IMapper _mapper;

        public MascotaController(VeterinariaDbContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        // GET: api/Mascota
        [HttpGet]
        public async Task<IActionResult> GetMascotas(int usuarioId)
        {
            var mascotas = await _context.Mascotas
                .Where(m => m.UsuarioId == usuarioId) // filtra por el usuarioId
                .ToListAsync();

            if (mascotas == null || mascotas.Count == 0)
                return NotFound("No se encontraron mascotas para este usuario");

            // Mapea las mascotas al MascotaDto
            var mascotasDto = _mapper.Map<List<MascotaDto>>(mascotas);

            return Ok(mascotasDto);
        }

        // GET: api/Mascota/{id}
        [HttpGet("{id}")]
        public async Task<IActionResult> GetMascotaById(int id)
        {
            var mascota = await _context.Mascotas.FindAsync(id);
            if (mascota == null)
                return NotFound($"Mascota con ID {id} no encontrada");

            var mascotaDto = _mapper.Map<MascotaDto>(mascota);
            return Ok(mascotaDto);
        }

        // POST: api/Mascota
        [HttpPost]
        public async Task<IActionResult> CreateMascota([FromBody] MascotaDto mascotaDto)
        {
            if (mascotaDto == null)
                return BadRequest("La mascota es inválida");

            var mascota = _mapper.Map<Mascota>(mascotaDto);
            _context.Mascotas.Add(mascota);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetMascotaById), new { id = mascota.MascotaId }, _mapper.Map<MascotaDto>(mascota));
        }

        // PUT: api/Mascota/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateMascota(int id, [FromBody] MascotaDto mascotaDto)
        {
            if (id != mascotaDto.MascotaId)
                return BadRequest("El ID de la mascota no coincide");

            var mascota = await _context.Mascotas.FindAsync(id);
            if (mascota == null)
                return NotFound($"Mascota con ID {id} no encontrada");

            _mapper.Map(mascotaDto, mascota);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        // DELETE: api/Mascota/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteMascota(int id)
        {
            var mascota = await _context.Mascotas.FindAsync(id);
            if (mascota == null)
                return NotFound($"Mascota con ID {id} no encontrada");

            _context.Mascotas.Remove(mascota);
            await _context.SaveChangesAsync();
            return Ok($"Mascota con ID {id} eliminada exitosamente");
        }
    }
}
