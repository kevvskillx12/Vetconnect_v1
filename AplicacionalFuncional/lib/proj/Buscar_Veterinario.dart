import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'mapa.dart';

class BuscarVeterinario extends StatefulWidget {
  const BuscarVeterinario({super.key});

  @override
  _BuscarVeterinarioState createState() => _BuscarVeterinarioState();
}

class _BuscarVeterinarioState extends State<BuscarVeterinario> {
  List<Map<String, dynamic>> geolocalizaciones = [];
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchGeolocalizaciones();
  }

  Future<void> _fetchGeolocalizaciones() async {
    try {
      final response = await http.get(
        Uri.parse('http://www.probando.somee.com/api/Geolocalizacion'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        List<Map<String, dynamic>> todasLasGeolocalizaciones = data
            .map((geo) => {
                  "geolocalizacionId":
                      geo["geolocalizacionId"] ?? "Desconocido",
                  "latitud": geo["latitud"] ?? 0.0,
                  "longitud": geo["longitud"] ?? 0.0,
                  "descripcion": geo["descripcion"] ?? "Sin descripción"
                })
            .toList();

        setState(() {
          geolocalizaciones = todasLasGeolocalizaciones;
        });
      } else {
        throw Exception("Error al obtener las geolocalizaciones.");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredGeolocalizaciones =
        geolocalizaciones.where(
      (geo) {
        final id = geo["geolocalizacionId"].toString().toLowerCase();
        final descripcion = geo["descripcion"].toString().toLowerCase();
        final query = searchQuery.toLowerCase();
        return id.contains(query) || descripcion.contains(query);
      },
    ).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5EEC8),
      appBar: AppBar(
        title: const Text(
          'Veterinarios',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFA67B5B),
      ),
      body: geolocalizaciones.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Buscar',
                      hintText: 'Buscar ubicación...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  searchQuery = '';
                                });
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: filteredGeolocalizaciones.isEmpty
                      ? const Center(
                          child: Text(
                            "No se encontró ningún resultado",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: filteredGeolocalizaciones.length,
                          itemBuilder: (context, index) {
                            final geolocalizacion =
                                filteredGeolocalizaciones[index];
                            return Card(
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                title: Text(
                                  geolocalizacion['geolocalizacionId'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.brown[700],
                                  ),
                                ),
                                subtitle: Text(
                                  geolocalizacion['descripcion'],
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                trailing: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFA67B5B),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: const Icon(Icons.arrow_forward_ios,
                                      color: Colors.white, size: 18),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MapaScreen(
                                        geolocalizacionId: geolocalizacion[
                                            'geolocalizacionId'],
                                        latitud: geolocalizacion['latitud'],
                                        longitud: geolocalizacion['longitud'],
                                        descripcion:
                                            geolocalizacion['descripcion'],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
