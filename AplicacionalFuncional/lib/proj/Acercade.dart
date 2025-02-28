import 'package:flutter/material.dart';

class AcercaDeScreen extends StatelessWidget {
  const AcercaDeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Conoce sobre vetconnect',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: const Color(0xFFA67B5B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondovetconnectconhuellitas.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenido de la pantalla
          Container(
            color:
                Colors.transparent, // Mantener transparencia para ver la imagen
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  '¿Qué es VetConnect?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Descripción de VetConnect con fondo blanco y bordes redondeados
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    'VetConnect es una plataforma que combina una aplicación móvil y una aplicación web para ofrecer funcionalidades como la creación de perfiles de usuario y mascota, agendamiento de citas, historial médico, búsqueda de veterinarios y administración de servicios veterinarios. Esta solución tiene como objetivo simplificar los procesos relacionados con el cuidado de las mascotas y brindar una experiencia eficiente tanto para los dueños como para los veterinarios.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 30),

                // Firma de desarrollo
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: Colors.transparent, // Mantener transparencia
                  child: const Text(
                    'Desarrollado por el equipo de VetConnect',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),

                // Expanding container to fill space
                Expanded(child: Container()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
