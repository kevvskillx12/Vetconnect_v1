// services/mascota_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class MascotaService {
  final String baseUrl = 'http://www.probando.somee.com/api/Mascota';

  // Obtener todas las mascotas de un usuario por su UsuarioId
  Future<List<dynamic>> getMascotasByUsuarioId(int usuarioId) async {
    final response = await http.get(Uri.parse('$baseUrl?usuarioId=$usuarioId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar las mascotas');
    }
  }

  // Obtener una mascota por su MascotaId
  Future<Map<String, dynamic>> getMascotaById(int mascotaId) async {
    final response = await http.get(Uri.parse('$baseUrl/$mascotaId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar la mascota');
    }
  }
}
