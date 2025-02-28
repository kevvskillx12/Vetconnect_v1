using System.Threading.Tasks;

namespace VetConnect_v1.Services
{
    public interface INotificationService
    {
        Task<bool> EnviarNotificacion(string token, string titulo, string mensaje);
        void RegisterToken(string usuarioId, string token, string rol); // Ahora incluye el rol
        string GetToken(string usuarioId, string rol); // Se debe indicar si es cliente o veterinario
    }
}
