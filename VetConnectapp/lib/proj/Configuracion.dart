import 'package:flutter/material.dart';
import 'Pantalla_interfaz.dart'; // Asegúrate de tener esta pantalla importada
import 'Idioma.dart'; // Pantalla para seleccionar idioma
import 'Servicio_cliente.dart'; // Pantalla de servicio al cliente
import 'Acercade.dart'; // Pantalla de información sobre la app

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
              color: Colors.white, // Título en blanco
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color(0xFFA67B5B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Regresa a Pantalla_interfaz.dart al presionar el botón de retroceso
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const VetConnectScreen()),
            );
          },
        ),
      ),
      body: Container(
        color: const Color(0xFFF5EEC8), // Color de fondo
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección de Idioma
            _buildMenuItem(
              Icons.language,
              'Idioma',
              'Selecciona el idioma de la aplicación',
              context,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const IdiomaScreen()),
                );
              },
            ),
            const SizedBox(height: 20),

            // Sección de Servicio al Cliente
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

            // Sección Acerca de
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

            // Sección Cerrar sesión
            _buildMenuItem(
              Icons.exit_to_app,
              'Cerrar sesión',
              '',
              context,
              () {
                // Implementar lógica para cerrar sesión, por ejemplo, limpiar datos de sesión
                _cerrarSesion(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir las secciones del menú
  Widget _buildMenuItem(IconData icon, String title, String subtitle,
      BuildContext context, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFFA67B5B),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 15),
              Column(
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
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Lógica para cerrar sesión (puedes ajustarlo según cómo gestiones la sesión)
  void _cerrarSesion(BuildContext context) {
    // Aquí podrías limpiar datos de sesión si los tienes
    // Por ejemplo, SharedPreferences.clear() o lo que utilices para gestionar el estado de sesión

    // Luego, navega al login o pantalla principal
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const VetConnectScreen()),
    );
  }
}
