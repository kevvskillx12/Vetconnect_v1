using System;
using VetConnect_v1.Models;
using VetConnect_v1.Data;
namespace VetConnect_v1.Models
{
    public class Geolocalizacion
    {
        public string GeolocalizacionId { get; set; }
        public decimal Latitud { get; set; }
        public decimal Longitud { get; set; }
        public string Descripcion { get; set; }
    }
}
