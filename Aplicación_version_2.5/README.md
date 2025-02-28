// Configuracion inicial de la aplicacion //
using System;
using Microsoft.EntityFrameworkCore;
using VetConnect_v1.Data;
using VetConnect_v1.Mappings;
using AutoMapper;
using VetConnect_v1.Service;

var builder = WebApplication.CreateBuilder(args);

// Configurar CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyMethod()
              .AllowAnyHeader();
    });
});

// Configurar DbContext con cadena de conexión desde appsettings.json
builder.Services.AddDbContext<VeterinariaDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));


//Registrar el servicio
builder.Services.AddScoped<CitaService>();

// Registrar AutoMapper
builder.Services.AddAutoMapper(typeof(AutoMapperProfile));

// Configurar controladores y Swagger

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Usar CORS antes de Swagger y otros middlewares
app.UseCors("AllowAll");

 //Configurar Swagger para todos los entornos
app.UseSwagger();
app.UseSwaggerUI(c =>
{
    c.SwaggerEndpoint("/swagger/v1/swagger.json", "VetConnect API V1");
});

app.UseAuthorization();
app.MapControllers();

Console.WriteLine($"Aplicación corriendo en el entorno: {app.Environment.EnvironmentName}");
Console.WriteLine("Accede a Swagger en: http://localhost:5233/swagger");

app.Run();

// DTOS de la app //

// Citas // 
namespace VetConnect_v1.DTOs
{
    public class CitaDto
    {
        public int CitaId { get; set; }
        public DateTime FechaHora { get; set; }
        public int UsuarioId { get; set; }
        public string VeterinarioId { get; set; }
        public int MascotaId { get; set; }
        public string Estado { get; set; } // Ejemplo: Pendiente, Confirmada, Completada.
    }
}

// Login //
namespace VetConnect_v1.DTOs
{
    public class LoginDto
    {
        public string CorreoElectronico { get; set; }
        public string Contraseña { get; set; }
    }
}

// Mascotas // 
namespace VetConnect_v1.DTOs
{
    public class MascotaDto
    {
        public int MascotaId { get; set; }
        public string Nombre { get; set; }
        public string Tipo { get; set; }
        public string Raza { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public decimal Peso { get; set; }
        public string InformacionMedica { get; set; }
        public int UsuarioId { get; set; }
    }
}

// Register // 

namespace VetConnect_v1.DTOs
{
    public class RegisterDto
    {
        public string NombreCompleto { get; set; }
        public string CorreoElectronico { get; set; }
        public string Contraseña { get; set; } // Será encriptada antes de guardarla 
        public int Telefono { get; set; }
        public string Direccion { get; set; }
    }
}


//Tickets para soporte // 
namespace VetConnect_v1.DTOs
{
    public class TicketSoporteDto
    {
        public int TicketId { get; set; }
        public int UsuarioId { get; set; }
        public string Mensaje { get; set; }
        public string Estado { get; set; }
        public string Respuesta { get; set; }
    }
}

// Usuario // 
namespace VetConnect_v1.DTOs
{
    public class UsuarioDto
    {
        public int UsuarioId { get; set; }
        public string NombreCompleto { get; set; }
        public string CorreoElectronico { get; set; }
        public int Telefono { get; set; }
        public string TipoUsuario { get; set; }
        public string Direccion { get; set; }
    }
}

// Veterinario // 
namespace VetConnect_v1.DTOs
{
    public class VeterinarioDto
    {
        public string VeterinarioId { get; set; }
        public string NombreCompleto { get; set; }
        public string Especialidad { get; set; }
        public string Direccion { get; set; }
        public int HorarioAtencion { get; set; }
        public int Contacto { get; set; }
    }
}

// Contexto de la base de datos // 

using Microsoft.EntityFrameworkCore;
using VetConnect_v1.Models;

namespace VetConnect_v1.Data
{
    public class VeterinariaDbContext : DbContext
    {
        public VeterinariaDbContext(DbContextOptions<VeterinariaDbContext> options) : base(options) { }

        public DbSet<Usuario> Usuarios { get; set; }
        public DbSet<Mascota> Mascotas { get; set; }
        public DbSet<Veterinario> Veterinarios { get; set; }
        public DbSet<Cita> Citas { get; set; }
        public DbSet<Servicio> Servicios { get; set; }
        public DbSet<Configuracion> Configuraciones { get; set; }
        public DbSet<TicketSoporte> TicketSoporte { get; set; }
        public DbSet<Geolocalizacion> Geolocalizaciones { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Configuración de claves primarias y relaciones
            modelBuilder.Entity<TicketSoporte>()
                .HasKey(t => t.TicketId);  // Clave primaria

            modelBuilder.Entity<TicketSoporte>()
                .HasOne(t => t.Usuario)  // Relación con Usuario
                .WithMany()
                .HasForeignKey(t => t.UsuarioId)
                .OnDelete(DeleteBehavior.NoAction);

            modelBuilder.Entity<Cita>()
                .HasOne(c => c.Usuario)
                .WithMany()
                .HasForeignKey(c => c.UsuarioId)
                .OnDelete(DeleteBehavior.NoAction);

            modelBuilder.Entity<Geolocalizacion>()
                .Property(g => g.Latitud)
                .HasColumnType("decimal(9,6)");

            modelBuilder.Entity<Geolocalizacion>()
                .Property(g => g.Longitud)
                .HasColumnType("decimal(9,6)");

            modelBuilder.Entity<Mascota>()
                .Property(m => m.Peso)
                .HasColumnType("decimal(5,2)");
        }
    }
}

/// Controladores /// 

// Login // 

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

// Cita // 

using Microsoft.AspNetCore.Mvc;
using VetConnect_v1.Data;
using VetConnect_v1.Models;
using Microsoft.EntityFrameworkCore;
using AutoMapper;
using VetConnect_v1.DTOs;
using VetConnect_v1.Service;  // Asegúrate de importar el espacio de nombres correcto
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
        private readonly CitaService _citaService;

        public CitaController(VeterinariaDbContext context, IMapper mapper, CitaService citaService)
        {
            _context = context;
            _mapper = mapper;
            _citaService = citaService;
        }

        // GET: api/Cita
        [HttpGet]
        public async Task<IActionResult> GetCitas()
        {
            try
            {
                var citas = await _context.Citas.ToListAsync();
                var citasDto = _mapper.Map<List<CitaDto>>(citas);
                return Ok(citasDto);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Error al obtener las citas", details = ex.Message });
            }
        }

        // GET: api/Cita/{id}
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

        // POST: api/Cita
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

                return Ok();  // Ya no es necesario devolver citas próximas
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Error al crear la cita", details = ex.Message });
            }
        }

        // PUT: api/Cita/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateCita(int id, [FromBody] CitaDto citaDto)
        {
            if (id != citaDto.CitaId)
                return BadRequest("El ID de la cita no coincide");

            try
            {
                var citaExistente = await _context.Citas.FindAsync(id);
                if (citaExistente == null)
                    return NotFound($"Cita con ID {id} no encontrada");

                _mapper.Map(citaDto, citaExistente);
                await _context.SaveChangesAsync();

                return NoContent();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Error al actualizar la cita", details = ex.Message });
            }
        }

        // DELETE: api/Cita/{id}
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

// Configuracion // 

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

// Geolocalizacion // 

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

// Mascotas // 

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
        public async Task<IActionResult> GetMascotas()
        {
            var mascotas = await _context.Mascotas.ToListAsync();
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

// Servicio veterinario // 

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

// Tickets de soporte //

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

// Usuario //

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

// Veterinario // 

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

