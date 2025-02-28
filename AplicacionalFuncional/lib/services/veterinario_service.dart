import 'dart:convert';
import 'package:http/http.dart' as http;

class VeterinarioService {
  final String baseUrl = 'http://www.probando.somee.com/api/Veterinario';

  Future<List<dynamic>> buscarVeterinarios(String query) async {
    try {
      final response = await http.get(Uri.parse(baseUrl), headers: {
        'accept': '*/*',
      });

      if (response.statusCode == 200) {
        List<dynamic> veterinarios = json.decode(response.body);

        // Filtrar los resultados basados en el query
        List<dynamic> resultadosFiltrados = veterinarios.where((vet) {
          String nombre = vet['nombreCompleto'].toString().toLowerCase();
          String id = vet['veterinarioId'].toString().toLowerCase();
          String queryLower = query.toLowerCase();

          // Buscar coincidencias en el nombre o en el ID
          return nombre.contains(queryLower) || id.contains(queryLower);
        }).toList();

        return resultadosFiltrados;
      } else {
        throw Exception('Error al buscar veterinarios: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }
}
