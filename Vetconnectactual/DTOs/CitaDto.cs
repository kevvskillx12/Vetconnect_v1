namespace VetConnect_v1.DTOs
{
    public class CitaDto
    {
        public int CitaId { get; set; }
        public DateTime FechaHora { get; set; }
        public int UsuarioId { get; set; }
        public string VeterinarioId { get; set; }
        public int MascotaId { get; set; }
        public string Estado { get; set; } // Ejemplo: Pendiente, Confirmada, Completada.
    }
}
