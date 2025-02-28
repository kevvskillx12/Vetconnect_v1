import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatbotService {
  final String apiUrl =
      "http://www.probando.somee.com/api/chatbot/preguntar"; // Reemplaza con la URL de tu API

  Future<String> obtenerRespuestaIA(String pregunta) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"pregunta": pregunta}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["respuesta"]; // Devuelve la respuesta de la IA
      } else {
        return "Error en la solicitud: ${response.statusCode}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }
}
