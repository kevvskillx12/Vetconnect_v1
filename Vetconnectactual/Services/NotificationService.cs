using FirebaseAdmin.Messaging;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace VetConnect_v1.Services
{
    public class NotificationService : INotificationService
    {
        // Diccionario para almacenar los tokens en memoria (clave: usuarioId, valor: token)
        private readonly Dictionary<string, string> _fcmTokens = new Dictionary<string, string>();

        public void RegisterToken(string usuarioId, string token)
        {
            if (_fcmTokens.ContainsKey(usuarioId))
            {
                _fcmTokens[usuarioId] = token; // Actualiza el token si ya existe
            }
            else
            {
                _fcmTokens.Add(usuarioId, token); // Agrega un nuevo token
            }
        }

        public string GetToken(string usuarioId)
        {
            return _fcmTokens.TryGetValue(usuarioId, out var token) ? token : null;
        }

        public async Task<bool> EnviarNotificacion(string token, string titulo, string mensaje)
        {
            try
            {
                var message = new Message()
                {
                    Token = token,
                    Notification = new Notification()
                    {
                        Title = titulo,
                        Body = mensaje
                    },
                    Data = new Dictionary<string, string>
                    {
                        { "click_action", "FLUTTER_NOTIFICATION_CLICK" },
                        { "id", "1" },
                        { "status", "done" }
                    }
                };

                string response = await FirebaseMessaging.DefaultInstance.SendAsync(message);
                Console.WriteLine($"Notificación enviada correctamente: {response}");
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error al enviar la notificación: {ex.Message}");
                return false;
            }
        }
    }
}
