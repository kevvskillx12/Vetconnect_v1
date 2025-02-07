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
}
