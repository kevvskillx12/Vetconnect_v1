using Microsoft.AspNetCore.Mvc;
using VetConnect_v1.DTOs;
using VetConnect_v1.Models;
using VetConnect_v1.Data;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;
using System;

namespace VetConnect_v1.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly VeterinariaDbContext _context;

        public AuthController(VeterinariaDbContext context)
        {
            _context = context;
        }

        // Endpoint de login
        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginDto loginDto)
        {
            if (loginDto == null || string.IsNullOrWhiteSpace(loginDto.CorreoElectronico) || string.IsNullOrWhiteSpace(loginDto.Contraseña))
            {
                return BadRequest(new { message = "Correo y contraseña son obligatorios." });
            }

            // Buscar el usuario en la base de datos por correo
            var usuario = await _context.Usuarios
                .FirstOrDefaultAsync(u => u.CorreoElectronico == loginDto.CorreoElectronico);

            if (usuario == null)
            {
                return Unauthorized(new { message = "Usuario no registrado." });
            }

            // Compara la contraseña en texto plano
            if (usuario.Contraseña != loginDto.Contraseña)
            {
                return Unauthorized(new { message = "Contraseña incorrecta." });
            }

            return Ok(new
            {
                message = "Inicio de sesión exitoso",
                usuarioId = usuario.UsuarioId,
                nombre = usuario.NombreCompleto,
                tipoUsuario = usuario.TipoUsuario
            });
        }

        // Endpoint de registro
        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] RegisterDto registerDto)
        {
            // Verificar si ya existe un usuario con el mismo correo
            if (await _context.Usuarios.AnyAsync(u => u.CorreoElectronico == registerDto.CorreoElectronico))
            {
                return BadRequest(new { message = "El correo ya está registrado." });
            }

            // En este ejemplo, no se encripta la contraseña; se almacena en texto plano.
            var usuario = new Usuario
            {
                NombreCompleto = registerDto.NombreCompleto,
                CorreoElectronico = registerDto.CorreoElectronico,
                Contraseña = registerDto.Contraseña, // Guardamos la contraseña tal como se envía
                Telefono = registerDto.Telefono,
                Direccion = registerDto.Direccion,
                TipoUsuario = "Cliente",              // Valor fijo para clientes
                FechaRegistro = DateTime.UtcNow,        // Se usa la fecha y hora actual
                VeterinarioId = null                   // Para clientes, VeterinarioId es null
            };

            _context.Usuarios.Add(usuario);
            await _context.SaveChangesAsync();

            return Ok(new { message = "Usuario registrado exitosamente" });
        }
    }
}
