using System;
using VetConnect_v1.Models;
using VetConnect_v1.Data;

namespace VetConnect_v1.Models
{
    public class Mascota
    {
        public int MascotaId { get; set; }
        public string Nombre { get; set; }
        public string Tipo { get; set; } // Perro, Gato, etc.
        public string Raza { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public decimal Peso { get; set; }
        public string InformacionMedica { get; set; } // Vacunas, Alergias, Historial médico
        public int UsuarioId { get; set; } // Dueño de la mascota

        // Propiedad de navegación
        public Usuario Usuario { get; set; }  // Relación con Usuario
    }
}
