import 'package:flutter/material.dart';
import 'Inicio_sesion.dart'; // Importamos la pantalla de inicio de sesión

class RegistroExitosoScreen extends StatelessWidget {
  const RegistroExitosoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      if (Navigator.canPop(context)) {
        Navigator.pop(context); // Cierra la pantalla actual si es posible
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const LoginScreen(), // Redirigir a la pantalla de inicio de sesión
        ),
      );
    });

    return const Scaffold(
      backgroundColor: Color(0xFFF5EEC8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              '¡Tus datos se han guardado con éxito!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
