import 'package:flutter/material.dart';
import 'package:vetconnectapp/services/usuario_service.dart';

class InformacionUsuario extends StatefulWidget {
  final int usuarioId;

  const InformacionUsuario({super.key, required this.usuarioId});

  @override
  _InformacionUsuarioState createState() => _InformacionUsuarioState();
}

class _InformacionUsuarioState extends State<InformacionUsuario> {
  Map<String, dynamic>? usuario;
  bool isLoading = true;

  final UsuarioService _usuarioService = UsuarioService();

  @override
  void initState() {
    super.initState();
    _loadUsuario();
  }

  Future<void> _loadUsuario() async {
    try {
      final usuarioData =
          await _usuarioService.getUsuarioById(widget.usuarioId);
      print("Usuario obtenido desde API: $usuarioData");
      setState(() {
        usuario = usuarioData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener usuario: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil de usuario',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFA67B5B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : usuario == null
              ? const Center(
                  child: Text(
                    'No se encontró información del usuario.',
                    style: TextStyle(fontSize: 18, color: Colors.brown),
                  ),
                )
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('assets/fondovetconnectconhuellitas.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person,
                          size: 80,
                          color: Color(0xFFA67B5B),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          usuario!["nombreCompleto"] ?? "Desconocido",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFA67B5B),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          usuario!["correoElectronico"] ??
                              "Correo no disponible",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Información adicional',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFA67B5B),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildInfoRow(
                            'Teléfono:',
                            usuario!["telefono"]?.toString() ??
                                "No disponible"),
                        _buildInfoRow('Tipo de Usuario:',
                            usuario!["tipoUsuario"] ?? "No especificado"),
                        _buildInfoRow('Dirección:',
                            usuario!["direccion"] ?? "No disponible"),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
