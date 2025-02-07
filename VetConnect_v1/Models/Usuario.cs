using System;
using VetConnect_v1.Models;
using VetConnect_v1.Data;
namespace VetConnect_v1.Models
{
    public class Usuario
    {
        public int UsuarioId { get; set; }
        public string NombreCompleto { get; set; }
        public string CorreoElectronico { get; set; }
        public string Contraseña { get; set; }
        public int Telefono { get; set; }
        public string TipoUsuario { get; set; } // Cliente, Veterinario, Administrador
        public string Direccion { get; set; } // Opcional
        public DateTime FechaRegistro { get; set; }

        // Relación opcional con veterinario
        public string? VeterinarioId { get; set; }   // Solo para veterinarios
        public Veterinario? Veterinario { get; set; }
        
    }
}
