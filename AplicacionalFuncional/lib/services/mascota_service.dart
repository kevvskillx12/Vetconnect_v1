import 'dart:convert';
import 'package:http/http.dart' as http;

class MascotaService {
  final String _baseUrl =
      'http://www.probando.somee.com/api'; // Cambia la URL según tu configuración

  Future<List<dynamic>> getMascotasByUsuarioId(int usuarioId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/Mascota?usuarioId=$usuarioId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Devuelve las mascotas del usuario
    } else {
      throw Exception('Error al cargar las mascotas');
    }
  }
}
