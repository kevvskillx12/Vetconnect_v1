using System;
using VetConnect_v1.Models;
using VetConnect_v1.Data;
namespace VetConnect_v1.Models
{
    public class Configuracion
    {
        public int ConfiguracionId { get; set; }
        public string IdiomaPreferido { get; set; }
        public bool Notificaciones { get; set; }
        public int UsuarioId { get; set; }

        public Usuario Usuario { get; set; }  // Relación con Usuario
    }
}
