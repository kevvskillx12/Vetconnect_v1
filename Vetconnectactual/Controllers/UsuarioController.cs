using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using VetConnect_v1.Data;
using VetConnect_v1.Models;
using VetConnect_v1.DTOs;
using AutoMapper;

namespace VetConnect_v1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UsuarioController : ControllerBase
    {
        private readonly VeterinariaDbContext _context;
        private readonly IMapper _mapper;

        public UsuarioController(VeterinariaDbContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        // Obtener todos los usuarios
        [HttpGet]
        public async Task<IActionResult> GetUsuarios()
        {
            try
            {
                var usuarios = await _context.Usuarios.ToListAsync();
                var usuariosDto = _mapper.Map<List<UsuarioDto>>(usuarios);

                if (usuariosDto.Count == 0)
                {
                    return NotFound("No se encontraron usuarios");
                }

                return Ok(usuariosDto);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Error al obtener los usuarios", details = ex.Message });
            }
        }

        // Obtener un usuario por su ID
        [HttpGet("{id}")]
        public async Task<IActionResult> GetUsuarioById(int id)
        {
            try
            {
                var usuario = await _context.Usuarios.FindAsync(id);

                if (usuario == null)
                {
                    return NotFound($"Usuario con id {id} no encontrado");
                }

                var usuarioDto = _mapper.Map<UsuarioDto>(usuario);
                return Ok(usuarioDto);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Error al obtener el usuario", details = ex.Message });
            }
        }

        // Crear un nuevo usuario
        [HttpPost]
        public async Task<IActionResult> CreateUsuario([FromBody] UsuarioDto usuarioDto)
        {
            try
            {
                if (usuarioDto == null)
                {
                    return BadRequest("Datos del usuario inválidos");
                }

                // Verificar si el correo ya está registrado
                var usuarioExistente = await _context.Usuarios.FirstOrDefaultAsync(u => u.CorreoElectronico == usuarioDto.CorreoElectronico);
                if (usuarioExistente != null)
                {
                    return Conflict("El correo electrónico ya está registrado");
                }

                // Mapear DTO a entidad Usuario
                var usuario = _mapper.Map<Usuario>(usuarioDto);
                usuario.FechaRegistro = DateTime.UtcNow;

                _context.Usuarios.Add(usuario);
                await _context.SaveChangesAsync();

                var usuarioCreadoDto = _mapper.Map<UsuarioDto>(usuario);
                return CreatedAtAction(nameof(GetUsuarioById), new { id = usuario.UsuarioId }, usuarioCreadoDto);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Error al crear el usuario", details = ex.Message });
            }
        }

        // Actualizar un usuario
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateUsuario(int id, [FromBody] UsuarioDto usuarioDto)
        {
            try
            {
                if (id != usuarioDto.UsuarioId)
                {
                    return BadRequest("El ID del usuario no coincide");
                }

                var usuarioExistente = await _context.Usuarios.FindAsync(id);
                if (usuarioExistente == null)
                {
                    return NotFound($"Usuario con id {id} no encontrado");
                }

                _mapper.Map(usuarioDto, usuarioExistente);
                await _context.SaveChangesAsync();

                return NoContent();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Error al actualizar el usuario", details = ex.Message });
            }
        }

        // Eliminar un usuario
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUsuario(int id)
        {
            try
            {
                var usuario = await _context.Usuarios.FindAsync(id);

                if (usuario == null)
                {
                    return NotFound($"Usuario con id {id} no encontrado");
                }

                _context.Usuarios.Remove(usuario);
                await _context.SaveChangesAsync();

                return Ok($"Usuario con id {id} eliminado exitosamente");
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Error al eliminar el usuario", details = ex.Message });
            }
        }
    }
}
