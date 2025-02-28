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
