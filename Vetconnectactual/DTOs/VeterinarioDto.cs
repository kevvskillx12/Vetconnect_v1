namespace VetConnect_v1.DTOs
{
    public class VeterinarioDto
    {
        public string VeterinarioId { get; set; }
        public string NombreCompleto { get; set; }
        public string Especialidad { get; set; }
        public string Direccion { get; set; }
        public int? HorarioAtencion { get; set; }
        public int? Contacto { get; set; }
    }
}
