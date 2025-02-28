using System;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;

namespace VetConnect_v1.Services
{
    public class ChatbotService
    {
        private readonly HttpClient _httpClient;
        private readonly string _apiKey;
        private static readonly string[] HuggingFaceModels = new[]
        {
            "microsoft/Phi-3.5-mini-instruct"
        };

        public ChatbotService(HttpClient httpClient, IConfiguration configuration)
        {
            _httpClient = httpClient;
            _apiKey = configuration["HuggingFace:ApiKey"];

            if (string.IsNullOrEmpty(_apiKey))
            {
                Console.WriteLine("❌ ERROR: La API Key de Hugging Face es NULL o está vacía.");
                throw new Exception("No se encontró la API Key de Hugging Face. Verifica appsettings.json.");
            }
            else
            {
                Console.WriteLine($"🔹 API Key usada: {_apiKey.Substring(0, 5)}********");
            }
        }

        private string GetApiUrl(string modelName)
        {
            return $"https://api-inference.huggingface.co/models/{modelName}";
        }

        private string GetRandomModel()
        {
            Random random = new Random();
            int index = random.Next(HuggingFaceModels.Length);
            return HuggingFaceModels[index];
        }

        private async Task<string> TraducirTexto(string texto, string sourceLang, string targetLang)
        {
            var requestBody = new
            {
                q = texto,
                source = sourceLang,
                target = targetLang,
                format = "text"
            };

            var json = JsonSerializer.Serialize(requestBody);
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            // Usar la API de LibreTranslate
            var response = await _httpClient.PostAsync("https://es.libretranslate.com/translate", content);

            if (response.IsSuccessStatusCode)
            {
                var responseBody = await response.Content.ReadAsStringAsync();
                var translationResult = JsonSerializer.Deserialize<JsonElement>(responseBody);

                if (translationResult.TryGetProperty("translatedText", out var translatedText))
                {
                    return translatedText.GetString();
                }
            }

            // Manejo de errores de traducción
            return texto; // Si la traducción falla, devuelve el texto original
        }

        public async Task<string> ObtenerRespuestaIA(string pregunta)
        {
            // Traducir la pregunta a inglés
            var preguntaIngles = await TraducirTexto(pregunta, "es", "en");

            string modelo = GetRandomModel();
            try
            {
                var prompt = "You are an expert veterinarian and will only answer questions related to veterinary medicine. Provide direct, precise, and complete responses in a single paragraph, without unnecessary or ambiguous information. Explain only the essentials using clear and simple language. Use an empathetic and respectful tone, avoiding insensitive responses. If the question is not related to veterinary medicine, kindly and directly indicate that you only handle this topic. In addition to answering questions, you can schedule an appointment at a veterinary clinic. To do so, ask for the following details: Name of the veterinary clinic, Date of the appointment, and Time of the appointment. Upon receiving the details, respond with: 'Now please wait for the doctor to confirm your appointment, thank you for your patience.' If the user wishes to cancel an appointment, offer the option to cancel the newly scheduled appointment or any previous appointments. Ensure correct wording, without spelling errors or strange characters. Do not repeat the question in your response.\n" +
             $"Usuario: : {preguntaIngles}\nAsistente:";

                var requestBody = new
                {
                    inputs = prompt,
                    parameters = new
                    {
                        max_new_tokens = 250,
                        temperature = 0.5,
                        repetition_penalty = 2.0,
                        top_p = 0.9,
                        stop = new[] { "</s>" }
                    }
                };

                var json = JsonSerializer.Serialize(requestBody);
                var content = new StringContent(json, Encoding.UTF8, "application/json");

                _httpClient.DefaultRequestHeaders.Clear();
                _httpClient.DefaultRequestHeaders.Add("Authorization", $"Bearer {_apiKey}");

                var apiUrl = GetApiUrl(modelo);
                var response = await _httpClient.PostAsync(apiUrl, content);

                if (response.IsSuccessStatusCode)
                {
                    var responseBody = await response.Content.ReadAsStringAsync();
                    var responseData = JsonSerializer.Deserialize<JsonElement>(responseBody);

                    if (responseData[0].TryGetProperty("generated_text", out var generatedTextProperty))
                    {
                        var generatedText = generatedTextProperty.GetString();
                        var respuestaLimpia = generatedText.Replace(prompt, "").Trim();

                        // Eliminar texto en inglés y hashtags no deseados
                        int pos = respuestaLimpia.IndexOf("ASPECTS TO CONCERN AND SOLUTIONS IN SHORT PARAGRAPH");
                        if (pos > 0)
                        {
                            respuestaLimpia = respuestaLimpia.Substring(0, pos).Trim();
                        }

                        if (string.IsNullOrWhiteSpace(respuestaLimpia) || respuestaLimpia.Contains("Error"))
                        {
                            return "Lo siento, no pude generar una respuesta útil. Por favor, consulta a un veterinario.";
                        }

                        // Traducir la respuesta de vuelta a español
                        var respuestaEspanol = await TraducirTexto(respuestaLimpia, "en", "es");
                        return respuestaEspanol;
                    }
                    else
                    {
                        return "Error: No se encontró 'generated_text' en la respuesta de Hugging Face.";
                    }
                }
                else
                {
                    var errorResponse = await response.Content.ReadAsStringAsync();
                    if (response.StatusCode == System.Net.HttpStatusCode.BadRequest && errorResponse.Contains("Pro subscription"))
                    {
                        return "Error: El modelo requiere una suscripción Pro. Por favor, verifica tu suscripción.";
                    }
                    else if (response.StatusCode == System.Net.HttpStatusCode.TooManyRequests)
                    {
                        return "Error: Se alcanzó el límite de uso. Por favor, intenta nuevamente más tarde.";
                    }
                    else
                    {
                        return $"Error al conectar con Hugging Face: {response.StatusCode} - {errorResponse}";
                    }
                }
            }
            catch (Exception ex)
            {
                return $"Ocurrió un error al procesar la solicitud: {ex.Message}";
            }
        }
    }
}
