import 'package:flutter/material.dart';

class ServicioClienteScreen extends StatelessWidget {
  const ServicioClienteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Servicio al Cliente',
          style: TextStyle(color: Colors.white),
        ),
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
              'Brindar ayuda o soporte:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.phone_in_talk),
              title: Text('Llamada al servicio al cliente'),
            ),
            const ListTile(
              leading: Icon(Icons.mail),
              title: Text('Enviar correo electrónico'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nuestros agentes están disponibles para ayudarte con cualquier duda o problema que puedas tener. ¡Estamos aquí para ayudarte!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
