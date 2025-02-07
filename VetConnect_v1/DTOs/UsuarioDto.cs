namespace VetConnect_v1.DTOs
{
    public class UsuarioDto
    {
        public int UsuarioId { get; set; }
        public string NombreCompleto { get; set; }
        public string CorreoElectronico { get; set; }
        public int Telefono { get; set; }
        public string TipoUsuario { get; set; }
        public string Direccion { get; set; }
    }
}