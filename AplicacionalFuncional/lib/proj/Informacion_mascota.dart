import 'package:flutter/material.dart';
import 'package:vetconnectapp/services/mascota_service.dart';

class InformacionMascota extends StatefulWidget {
  final int usuarioId;

  const InformacionMascota({super.key, required this.usuarioId});

  @override
  _InformacionMascotaState createState() => _InformacionMascotaState();
}

class _InformacionMascotaState extends State<InformacionMascota> {
  List<dynamic> mascotas = [];
  bool isLoading = true;
  final MascotaService _mascotaService = MascotaService();

  @override
  void initState() {
    super.initState();
    _loadMascotas();
  }

  Future<void> _loadMascotas() async {
    try {
      final mascotasData =
          await _mascotaService.getMascotasByUsuarioId(widget.usuarioId);
      print("Mascotas obtenidas: $mascotasData");

      final filteredMascotas = mascotasData.where((mascota) {
        return mascota['usuarioId'] == widget.usuarioId;
      }).toList();

      setState(() {
        mascotas = filteredMascotas;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Información de la Mascota',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: const Color(0xFFA67B5B),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondovetconnectconhuellitas.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : mascotas.isEmpty
                ? const Center(
                    child: Text(
                      'No tienes mascotas registradas.',
                      style: TextStyle(fontSize: 18, color: Colors.brown),
                    ),
                  )
                : ListView.builder(
                    itemCount: mascotas.length,
                    itemBuilder: (context, index) {
                      final mascota = mascotas[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                'Nombre: ${mascota["nombre"]}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text('Tipo: ${mascota["tipo"]}',
                                  style: const TextStyle(color: Colors.brown)),
                              Text('Raza: ${mascota["raza"]}',
                                  style: const TextStyle(color: Colors.brown)),
                              Text(
                                  'Fecha de Nacimiento: ${mascota["fechaNacimiento"]}',
                                  style: const TextStyle(color: Colors.brown)),
                              Text('Peso: ${mascota["peso"]} kg',
                                  style: const TextStyle(color: Colors.brown)),
                              Text(
                                  'Información Médica: ${mascota["informacionMedica"]}',
                                  style: const TextStyle(color: Colors.brown)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
