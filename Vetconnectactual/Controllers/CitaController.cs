using Microsoft.AspNetCore.Mvc;
using VetConnect_v1.Data;
using VetConnect_v1.Models;
using Microsoft.EntityFrameworkCore;
using AutoMapper;
using VetConnect_v1.DTOs;
using VetConnect_v1.Services;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System;

namespace VetConnect_v1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CitaController : ControllerBase
    {
        private readonly VeterinariaDbContext _context;
        private readonly IMapper _mapper;
        private readonly INotificationService _notificationService;

        public CitaController(VeterinariaDbContext context, IMapper mapper, INotificationService notificationService)
        {
            _context = context;
            _mapper = mapper;
            _notificationService = notificationService;
        }

        // GET: api/Cita/usuario/{id} (Obtener citas futuras de un usuario específico)
        [HttpGet("usuario/{id}")]
        public async Task<IActionResult> GetCitasPorUsuario(int id)
        {
            try
            {
                var citas = await _context.Citas
                    .Where(c => c.UsuarioId == id && c.FechaHora > DateTime.Now)
                    .OrderBy(c => c.FechaHora)
                    .ToListAsync();

                if (citas == null || citas.Count == 0)
                {
                    return NotFound("No hay citas próximas para este usuario.");
                }

                var citasDto = _mapper.Map<List<CitaDto>>(citas);
                return Ok(citasDto);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Error al obtener las citas", details = ex.Message });
            }
        }

        // GET: api/Cita/{id} (Obtener una cita específica por su ID)
        [HttpGet("{id}")]
        public async Task<IActionResult> GetCitaById(int id)
        {
            try
            {
                var cita = await _context.Citas.FindAsync(id);
                if (cita == null)
                    return NotFound($"Cita con ID {id} no encontrada");

                var citaDto = _mapper.Map<CitaDto>(cita);
                return Ok(citaDto);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Error al obtener la cita", details = ex.Message });
            }
        }

        // POST: api/Cita (Crear una nueva cita)
        [HttpPost]
        public async Task<IActionResult> CreateCita([FromBody] CitaDto citaDto)
        {
            try
            {
                if (citaDto == null)
                    return BadRequest("Datos de la cita inválidos");

                var cita = _mapper.Map<Cita>(citaDto);
                cita.Estado = "Pendiente";

                if (cita.FechaHora <= DateTime.Now)
                {
                    return BadRequest("La fecha de la cita debe ser futura.");
                }

                _context.Citas.Add(cita);
                await _context.SaveChangesAsync();

                // Obtener el token FCM del veterinario desde el servicio (almacenamiento en memoria)
                string tokenFCM = _notificationService.GetToken(cita.VeterinarioId);
                if (string.IsNullOrEmpty(tokenFCM))
                    return BadRequest("Token FCM no registrado para el veterinario.");

                // Enviar notificación push: Se pasan tres parámetros (token, título y mensaje)
                await _notificationService.EnviarNotificacion(
                    tokenFCM,
                    "Nueva Cita Agendada",
                    $"Se ha agendado una nueva cita para el {cita.FechaHora}."
                );

                return Ok(new { message = "Cita creada y notificación enviada correctamente" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Error al crear la cita", details = ex.Message });
            }
        }

        // PUT: api/Cita/{id} (Actualizar una cita existente)
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateCita(int id, [FromBody] CitaDto citaDto)
        {
            if (id != citaDto.CitaId)
                return BadRequest("El ID de la cita no coincide");

            if (!new[] { "Pendiente", "Confirmada", "Completada" }.Contains(citaDto.Estado))
            {
                return BadRequest("Estado de la cita no válido");
            }

            try
            {
                var citaExistente = await _context.Citas.FindAsync(id);
                if (citaExistente == null)
                    return NotFound($"Cita con ID {id} no encontrada");

                _mapper.Map(citaDto, citaExistente);
                await _context.SaveChangesAsync();

                // Enviar notificación al usuario (ejemplo: usando un string de ejemplo para el token)
                await _notificationService.EnviarNotificacion(
                    $"UsuarioId_{citaDto.UsuarioId}",
                    "Cita Actualizada",
                    $"La cita ha sido actualizada a: {citaExistente.Estado}"
                );

                return Ok(new { message = "Cita actualizada correctamente", cita = _mapper.Map<CitaDto>(citaExistente) });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Error al actualizar la cita", details = ex.Message });
            }
        }

        // DELETE: api/Cita/{id} (Eliminar una cita)
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCita(int id)
        {
            try
            {
                var cita = await _context.Citas.FindAsync(id);
                if (cita == null)
                    return NotFound($"Cita con ID {id} no encontrada");

                _context.Citas.Remove(cita);
                await _context.SaveChangesAsync();
                return Ok($"Cita con ID {id} eliminada exitosamente");
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Error al eliminar la cita", details = ex.Message });
            }
        }
    }
}
