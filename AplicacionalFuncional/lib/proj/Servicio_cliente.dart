import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServicioClienteScreen extends StatelessWidget {
  const ServicioClienteScreen({super.key});

  void _enviarWhatsApp() async {
    const telefono = '+529992793021';
    final Uri url = Uri.parse('https://wa.me/$telefono');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo abrir WhatsApp';
    }
  }

  void _enviarCorreo() async {
    const email = 'vetconnect25@gmail.com';
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: Uri.encodeFull('Subject: Consulta de Servicio al Cliente'),
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'No se pudo abrir la aplicación de correo electrónico';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Servicio al Cliente',
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
          onPressed: () {
            Navigator.pop(context);
          },
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
            color: Colors.transparent, // Mantener transparencia
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 6,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.white,
                  child: InkWell(
                    onTap: _enviarWhatsApp,
                    borderRadius: BorderRadius.circular(15),
                    splashColor: const Color(0xFFA67B5B).withOpacity(0.3),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      leading: const Icon(
                        FontAwesomeIcons.whatsapp,
                        color: Color(0xFF25D366), // Color oficial de WhatsApp
                        size: 26,
                      ),
                      title: const Text(
                        'Enviar un mensaje de WhatsApp',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF5D4037),
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFFA67B5B),
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 6,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.white,
                  child: InkWell(
                    onTap: _enviarCorreo,
                    borderRadius: BorderRadius.circular(15),
                    splashColor: const Color(0xFFA67B5B).withOpacity(0.3),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      leading: const Icon(
                        Icons.email,
                        color: Colors.blue, // Color del icono de correo
                        size: 26,
                      ),
                      title: const Text(
                        'Enviar un correo electrónico',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF5D4037),
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFFA67B5B),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
