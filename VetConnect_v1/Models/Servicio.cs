using System;
using VetConnect_v1.Models;
using VetConnect_v1.Data;
namespace VetConnect_v1.Models
{
    public class Servicio
    {
        public int ServicioId { get; set; }
        public string Tipo { get; set; } // Consulta, Vacuna, etc.
        public DateTime Fecha { get; set; }
        public string VeterinarioId { get; set; }
        public int MascotaId { get; set; }
        public string Detalles { get; set; } // Descripción o detalles adicionales

        // Propiedades de navegación
        public Veterinario Veterinario { get; set; }  // Relación con Veterinario
        public Mascota Mascota { get; set; }  // Relación con Mascota
    }
}