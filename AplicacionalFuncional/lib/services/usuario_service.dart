import 'package:http/http.dart' as http;
import 'dart:convert';

class UsuarioService {
  Future<Map<String, dynamic>> getUsuarioById(int usuarioId) async {
    final response = await http.get(
      Uri.parse('http://www.probando.somee.com/api/Usuario/$usuarioId'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener el usuario: ${response.statusCode}');
    }
  }

  Future<bool> actualizarUsuario(
      int usuarioId, Map<String, dynamic> usuarioData) async {
    final response = await http.put(
      Uri.parse('http://www.probando.somee.com/api/Usuario/$usuarioId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(usuarioData),
    );

    return response.statusCode == 200;
  }
}
