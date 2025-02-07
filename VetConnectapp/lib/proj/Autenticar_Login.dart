import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _apiUrl = "http://www.probando.somee.com/api/Auth/login";

  static Future<Map<String, dynamic>> login(
      String correo, String contrasena) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "correoElectronico": correo.trim(),
          "contraseña":
              contrasena.trim(), // Si la API acepta "contraseña", mantenlo aquí
        }),
      );

      if (response.statusCode == 200) {
        return {"success": true, "data": jsonDecode(response.body)};
      } else {
        return {
          "success": false,
          "message": jsonDecode(response.body)["message"] ?? "Error en el login"
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
