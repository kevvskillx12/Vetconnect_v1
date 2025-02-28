using System;
using VetConnect_v1.Models;
using VetConnect_v1.Data;

namespace VetConnect_v1.Models
{
    public class Cita
    {
        public int CitaId { get; set; }
        public DateTime FechaHora { get; set; }
        public int UsuarioId { get; set; }
        public string VeterinarioId { get; set; }
        public int MascotaId { get; set; }
        public string Estado { get; set; } // Pendiente, Confirmada, Completada, etc.

        public Usuario Usuario { get; set; }  // Relación con Usuario
        public Veterinario Veterinario { get; set; }  // Relación con Veterinario
        public Mascota Mascota { get; set; }  // Relación con Mascota
    }
}