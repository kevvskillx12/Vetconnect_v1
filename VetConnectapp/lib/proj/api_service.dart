import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://www.probando.somee.com/api';

  // Aquí puedes mantener el código para otras funciones como obtener veterinarios, etc.
  Future<List<dynamic>> getVeterinarios() async {
    final response = await http.get(Uri.parse('$baseUrl/Veterinario'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load veterinarios');
    }
  }

  Future<void> createCita(Map<String, dynamic> citaData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Cita'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(citaData),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create cita');
    }
  }
}

class AutenticarRegistroServicio {
  static const String baseUrl = 'http://www.probando.somee.com/api';

  // Método para registrar un nuevo usuario
  static Future<Map<String, dynamic>> register(
    String nombre,
    String correo,
    String contrasena,
    int telefono,
    String direccion,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nombre': nombre,
        'correo': correo,
        'contrasena': contrasena,
        'telefono': telefono,
        'direccion': direccion,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // Respuesta del servidor
    } else {
      throw Exception('Failed to register user');
    }
  }
}
