import 'package:flutter/material.dart';
import 'proj/Inicio_sesion.dart'; // Importa la pantalla de inicio de sesión

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VetConnect',
      theme: ThemeData(primarySwatch: Colors.brown),
      home:
          const SplashScreen(), // Mantenemos el SplashScreen dentro de main.dart
      debugShowCheckedModeBanner: false,
    );
  }
}

// Pantalla de animación (Splash Screen)
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Espera 3 segundos antes de ir a LoginScreen
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EEC8),
      body: Center(
        child: Image.asset(
          'assets/vetconnectlogo.png', // Logo de la app
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
