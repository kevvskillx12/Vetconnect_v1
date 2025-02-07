import 'dart:convert';
import 'package:http/http.dart' as http;

class AutenticarRegistroServicio {
  static const String baseUrl = 'http://www.probando.somee.com/api';

  static Future<Map<String, dynamic>> register(
    String nombre,
    String correo,
    String contrasena, // Aquí mantenemos "contrasena" sin ñ
    int telefono,
    String direccion,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/Auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nombreCompleto': nombre,
          'correoElectronico': correo,
          'contraseña': contrasena, // Aquí sí usamos "contraseña" en JSON
          'telefono': telefono,
          'direccion': direccion,
        }),
      );

      if (response.statusCode == 200) {
        return {"success": true, "message": "Usuario registrado correctamente"};
      } else {
        return {
          "success": false,
          "message":
              jsonDecode(response.body)["message"] ?? "Error en el registro"
        };
      }
    } catch (e) {
      return {
        "success": false,
        "message": "Error de conexión. Inténtalo de nuevo."
      };
    }
  }
}
