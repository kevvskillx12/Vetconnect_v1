import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'mapa.dart'; // Asegúrate de que esta ruta sea correcta

class BuscarVeterinario extends StatefulWidget {
  const BuscarVeterinario({super.key});

  @override
  _BuscarVeterinarioState createState() => _BuscarVeterinarioState();
}

class _BuscarVeterinarioState extends State<BuscarVeterinario> {
  List<Map<String, dynamic>> geolocalizaciones = [];

  // Lista de geolocalizaciones, con el ID correspondiente
  final List<String> geolocalizacionIds = [
    "veterinaria-1",
    "GEO001",
    "GEO002",
    "GEO003",
    "veterinaria-2",
    "veterinaria-3",
    "veterinaria-4",
    "veterinaria-5",
    "veterinaria-6",
    "veterinaria-7"
  ];

  @override
  void initState() {
    super.initState();
    _fetchGeolocalizaciones();
  }

  // Obtener las geolocalizaciones usando las URLs de cada geolocalizacionId
  Future<void> _fetchGeolocalizaciones() async {
    List<Map<String, dynamic>> geos = [];
    for (var id in geolocalizacionIds) {
      final response = await http.get(
          Uri.parse('http://www.probando.somee.com/api/Geolocalizacion/$id'));
      if (response.statusCode == 200) {
        geos.add(json.decode(response
            .body)); // Agregar la respuesta al listado de geolocalizaciones
      } else {
        throw Exception('Error al cargar la geolocalización');
      }
    }

    setState(() {
      geolocalizaciones = geos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5EEC8),
      appBar: AppBar(
        title:
            Text('Buscar Veterinario', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color(0xFFA67B5B),
      ),
      body: geolocalizaciones.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator()) // Cargar indicador de progreso mientras obtenemos los datos
          : ListView.builder(
              itemCount: geolocalizaciones.length,
              itemBuilder: (context, index) {
                final geolocalizacion = geolocalizaciones[index];

                // Asegúrate de que latitud y longitud no sean nulas
                final latitud = geolocalizacion['latitud'] ?? 0.0;
                final longitud = geolocalizacion['longitud'] ?? 0.0;
                final descripcion = geolocalizacion['descripcion'] ??
                    'Descripción no disponible';

                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(geolocalizacion['geolocalizacionId']),
                    subtitle: Text(descripcion),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward, color: Colors.brown),
                      onPressed: () {
                        // Navegar a MapaScreen pasando la geolocalizacionId
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapaScreen(
                              geolocalizacionId:
                                  geolocalizacion['geolocalizacionId'],
                              latitud: latitud,
                              longitud: longitud,
                              descripcion: descripcion,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
