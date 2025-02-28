import 'package:flutter/material.dart';
import 'Pantalla_interfaz.dart'; // Pantalla principal
import 'Idioma.dart';
import 'Servicio_cliente.dart';
import 'Acercade.dart';
import 'Inicio_sesion.dart'; // Pantalla de inicio de sesión

class ConfiguracionScreen extends StatelessWidget {
  const ConfiguracionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Configuración',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color(0xFFA67B5B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const VetConnectScreen()),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          // Imagen de fondo
          Image.asset(
            'assets/fondovetconnectconhuellitas.png', // Ruta de la imagen
            fit: BoxFit.cover, // Asegura que la imagen cubra todo el fondo
            width: double.infinity,
            height: double.infinity,
          ),
          // Contenido de la pantalla
          Container(
            color: const Color(0xFFF5EEC8)
                .withOpacity(0.8), // Color de fondo con opacidad
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMenuItem(
                  Icons.language,
                  'Idioma',
                  'Selecciona el idioma de la aplicación',
                  context,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IdiomaScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  Icons.headset_mic,
                  'Servicio al Cliente',
                  'Brindar ayuda o soporte',
                  context,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ServicioClienteScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  Icons.info,
                  'Acerca de',
                  'Información sobre VetConnect',
                  context,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AcercaDeScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  Icons.exit_to_app,
                  'Cerrar sesión',
                  '',
                  context,
                  () {
                    _confirmarCerrarSesion(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle,
      BuildContext context, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFFA67B5B),
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    if (subtitle.isNotEmpty)
                      Text(
                        subtitle,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmarCerrarSesion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Cerrar sesión"),
          content: const Text("¿Estás seguro de que deseas cerrar sesión?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext)
                    .pop(); // Cierra el diálogo si elige "No"
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Cerró sesión de forma exitosa")),
                );
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                });
              },
              child: const Text("Sí"),
            ),
          ],
        );
      },
    );
  }
}
