import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CitaService {
  final String baseUrl = 'http://www.probando.somee.com/api/Cita';

  // Método para crear una cita (se asume que la API la crea y retorna status 200 en éxito)
  Future<bool> crearCita(Map<String, dynamic> citaData) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(citaData),
    );
    return response.statusCode == 200;
  }

  // Método para guardar una cita en SharedPreferences
  Future<void> guardarCita(Map<String, dynamic> citaJson) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> citas = prefs.getStringList('citas') ?? [];
    citas.add(json.encode(citaJson));
    await prefs.setStringList('citas', citas);
  }

  // Método para obtener las citas filtradas por usuario
  Future<List<String>> obtenerCitasUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usuarioId = prefs.getString('usuarioId');

    if (usuarioId == null) {
      return []; // Si no hay usuarioId almacenado, retorna una lista vacía
    }

    List<String> citas = prefs.getStringList('citas') ?? [];
    List<String> citasFiltradas = citas.where((cita) {
      var citaJson = json.decode(cita);
      return citaJson['usuarioId'].toString() ==
          usuarioId; // Comparación segura como String
    }).toList();

    return citasFiltradas;
  }

  // Método para actualizar el estado de una cita
  Future<void> actualizarEstadoCita(String citaId, String nuevoEstado) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> citas = prefs.getStringList('citas') ?? [];

    for (int i = 0; i < citas.length; i++) {
      var citaJson = json.decode(citas[i]);
      // Se compara como String para evitar conflictos de tipo
      if (citaJson['id'].toString() == citaId) {
        citaJson['estado'] = nuevoEstado;
        citas[i] = json.encode(citaJson);
        break;
      }
    }
    await prefs.setStringList('citas', citas);
  }
}
