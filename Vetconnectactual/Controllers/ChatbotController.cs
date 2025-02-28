using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using VetConnect_v1.Services;

namespace VetConnect_v1.Controllers
{
    [Route("api/chatbot")]
    [ApiController]
    public class ChatbotController : ControllerBase
    {
        private readonly ChatbotService _chatbotService;

        public ChatbotController(ChatbotService chatbotService)
        {
            _chatbotService = chatbotService;
        }

        // Modificado para aceptar un objeto JSON con un campo pregunta
        [HttpPost("preguntar")]
        public async Task<IActionResult> Preguntar([FromBody] PreguntaRequest request)
        {
            if (string.IsNullOrEmpty(request.Pregunta))
            {
                return BadRequest("El campo 'pregunta' es obligatorio.");
            }

            var respuesta = await _chatbotService.ObtenerRespuestaIA(request.Pregunta);
            return Ok(new { respuesta });
        }
    }

    // Clase para representar el cuerpo de la solicitud
    public class PreguntaRequest
    {
        public string Pregunta { get; set; }
    }
}
