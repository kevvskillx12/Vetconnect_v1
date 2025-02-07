import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart' as maplibre;
import 'package:geolocator/geolocator.dart';
import 'dart:math';

class MapaScreen extends StatefulWidget {
  final String geolocalizacionId;
  final double latitud;
  final double longitud;
  final String descripcion;

  MapaScreen({
    required this.geolocalizacionId,
    required this.latitud,
    required this.longitud,
    required this.descripcion,
  });

  @override
  _MapaScreenState createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  late maplibre.MaplibreMapController mapController;
  late maplibre.LatLng userLocation;
  bool isLocationLoaded = false;

  @override
  void initState() {
    super.initState();
    _getUserLocation(); // Llama al método que obtiene la ubicación del usuario
  }

  // Método para obtener la ubicación del usuario
  Future<void> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Los servicios de ubicación están desactivados.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permiso de ubicación denegado');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Permiso de ubicación permanentemente denegado');
    }

    // Si todo está bien, obtiene la ubicación del usuario
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      userLocation = maplibre.LatLng(position.latitude, position.longitude);
      isLocationLoaded =
          true; // Marca que la ubicación del usuario se ha cargado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mapa de Veterinario",
          style: TextStyle(color: Colors.white), // Texto en blanco en el AppBar
        ),
        backgroundColor: Color(0xFFA67B5B), // Color del AppBar
      ),
      body: Container(
        color: Color(0xFFF5EEC8), // Color del cuerpo
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Centrado del texto
                children: [
                  Text(
                    widget.geolocalizacionId, // ID del veterinario
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color:
                            const Color.fromARGB(255, 0, 0, 0)), // Texto blanco
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.descripcion,
                    style: TextStyle(
                        color: const Color.fromARGB(
                            255, 0, 0, 0)), // Texto blanco para la descripción
                  ),
                ],
              ),
            ),
            // Limitar el tamaño del mapa
            Container(
              height:
                  300, // Altura del mapa (ajusta el valor según lo necesites)
              child: isLocationLoaded
                  ? maplibre.MaplibreMap(
                      styleString:
                          "https://api.mapbox.com/styles/v1/kevvskillx12/cm6pr45ey000201sba1yuf4hq/tiles/{z}/{x}/{y}?access_token=pk.eyJ1Ijoia2V2dnNraWxseDEyIiwiYSI6ImNtNnB3M3d6NjFuOXUyanB2cGE2ZTF6a2wifQ.B09jq_c4SYT-85sVLk7SKw", // Estilo de tu mapa
                      initialCameraPosition: maplibre.CameraPosition(
                        target:
                            maplibre.LatLng(widget.latitud, widget.longitud),
                        zoom: 14.0,
                      ),
                      onMapCreated: (controller) {
                        mapController = controller;

                        // Agregar marcador para la ubicación del veterinario
                        mapController.addSymbol(maplibre.SymbolOptions(
                          geometry:
                              maplibre.LatLng(widget.latitud, widget.longitud),
                          iconImage: "marker-15", // Icono de marcador
                        ));

                        // Agregar marcador para la ubicación del usuario
                        mapController.addSymbol(maplibre.SymbolOptions(
                          geometry: userLocation,
                          iconImage:
                              "marker-15", // Icono del marcador del usuario
                        ));
                      },
                    )
                  : Center(
                      child:
                          CircularProgressIndicator()), // Muestra un indicador de carga mientras se obtiene la ubicación
            ),
          ],
        ),
      ),
    );
  }
}
