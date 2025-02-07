using System;
using VetConnect_v1.Models;
using VetConnect_v1.Data;

namespace VetConnect_v1.Models
{
    public class TicketSoporte
    {
        public int TicketId { get; set; }  // Este debe ser la clave primaria
        public int UsuarioId { get; set; }
        public string Mensaje { get; set; }
        public string Estado { get; set; }  // Abierto, Cerrado, etc.
        public string Respuesta { get; set; }

        // relacion con usuario
        public Usuario Usuario { get; set; }
    }
}
