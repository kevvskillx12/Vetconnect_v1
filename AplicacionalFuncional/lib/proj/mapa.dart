import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapaScreen extends StatefulWidget {
  final String geolocalizacionId;
  final double latitud;
  final double longitud;
  final String descripcion;

  const MapaScreen({
    super.key,
    required this.geolocalizacionId,
    required this.latitud,
    required this.longitud,
    required this.descripcion,
  });

  @override
  _MapaScreenState createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  final MapController _mapController = MapController();
  LatLng? userLocation;
  bool isLocationLoaded = false;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) return;

    if (await _requestNotificationPermission()) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        setState(() {
          userLocation = LatLng(position.latitude, position.longitude);
          isLocationLoaded = true;
        });

        _mapController.move(userLocation!, 14);
      } catch (e) {
        print("Error obteniendo la posición: $e");
      }
    }
  }

  Future<bool> _requestNotificationPermission() async {
    return await Permission.notification.request().isGranted;
  }

  void _centrarEnVeterinaria() {
    _mapController.move(LatLng(widget.latitud, widget.longitud), 14);
  }

  void _centrarEnUsuario() {
    if (userLocation != null) {
      _mapController.move(userLocation!, 14);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Mapa de Veterinario", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFFA67B5B),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: LatLng(widget.latitud, widget.longitud),
              zoom: 14,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://api.maptiler.com/maps/streets-v2/{z}/{x}/{y}.png?key=uWHpmpfoQRG8y4Kes0nU",
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: LatLng(widget.latitud, widget.longitud),
                    child: Icon(Icons.location_on, color: Colors.red, size: 40),
                  ),
                  if (userLocation != null)
                    Marker(
                      width: 40.0,
                      height: 40.0,
                      point: userLocation!,
                      child: Icon(Icons.person_pin_circle,
                          color: Colors.blue, size: 40),
                    ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Card(
              elevation: 8,
              color: Color(0xFFF5EEC8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(widget.geolocalizacionId,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    SizedBox(height: 4),
                    Text(widget.descripcion,
                        style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: "btn1",
                  onPressed: _centrarEnVeterinaria,
                  backgroundColor: Color(0xFFA67B5B),
                  child: Icon(Icons.location_on, color: Colors.white),
                ),
                SizedBox(height: 12),
                FloatingActionButton(
                  heroTag: "btn2",
                  onPressed: _centrarEnUsuario,
                  backgroundColor: Color(0xFFA67B5B),
                  child: Icon(Icons.my_location, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
