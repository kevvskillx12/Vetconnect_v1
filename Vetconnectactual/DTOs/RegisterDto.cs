namespace VetConnect_v1.DTOs
{
    public class RegisterDto
    {
        public string NombreCompleto { get; set; }
        public string CorreoElectronico { get; set; }
        public string Contraseña { get; set; } // Será encriptada antes de guardarla 
        public int Telefono { get; set; }
        public string Direccion { get; set; }
    }
}
