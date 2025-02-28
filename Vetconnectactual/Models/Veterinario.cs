using System;
using VetConnect_v1.Models;
using VetConnect_v1.Data;

namespace VetConnect_v1.Models
{
    public class Veterinario
    {
        public string VeterinarioId { get; set; }
        public string NombreCompleto { get; set; }
        public string Especialidad { get; set; }
        public string Direccion { get; set; }
        public int? HorarioAtencion { get; set; }
        public int? Contacto { get; set; }

        //Nuevo campo para almacenar el token FCM
        public string TokenFCM { get; set; }
      
    }
}
