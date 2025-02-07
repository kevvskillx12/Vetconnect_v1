import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IdiomaScreen extends StatelessWidget {
  const IdiomaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Idioma'),
        backgroundColor: const Color(0xFFA67B5B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: const Color(0xFFF5EEC8),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Selecciona el idioma de la aplicación:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Español'),
              onTap: () {
                Get.updateLocale(const Locale('es', 'ES'));
                Get.back(); // Vuelve a la pantalla anterior
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Inglés'),
              onTap: () {
                Get.updateLocale(const Locale('en', 'US'));
                Get.back(); // Vuelve a la pantalla anterior
              },
            ),
          ],
        ),
      ),
    );
  }
}
