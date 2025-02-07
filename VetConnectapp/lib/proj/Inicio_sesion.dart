import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Autenticar_Login.dart'; // Importamos la conexión con la API
import 'pantalla_interfaz.dart'; // Pantalla principal después del login
import 'Crear_cuenta.dart'; // Pantalla de registro

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController correoController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  bool isLoading = false;

  Future<void> iniciarSesion() async {
    setState(() => isLoading = true);

    final resultado = await AuthService.login(
        correoController.text, contrasenaController.text);

    setState(() => isLoading = false);

    if (resultado["success"]) {
      //Guarda correo y contraseña
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('correo', correoController.text);
      await prefs.setString('contrasena', contrasenaController.text);
      await prefs.setInt(
          'usuarioId', resultado['data']['usuarioId']); //guarda el usuarioId

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Bienvenido(a), ${resultado['data']['nombre']}")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VetConnectScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resultado["message"])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color(0xFFF5EEC8),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/huellita_inicio_de_sesion.png', width: 30),
        ),
      ),
      body: Stack(
        children: [
          // Imagen en la esquina superior izquierda
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/huellita_inicio_de_sesion.png',
              width: 30,
            ),
          ),
          // Imagen en la esquina superior derecha
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/huellita_inicio_de_sesion.png',
              width: 30,
            ),
          ),
          // Imagen en la esquina inferior izquierda
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/huellita_inicio_de_sesion.png',
              width: 30,
            ),
          ),
          // Imagen en la esquina inferior derecha
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/huellita_inicio_de_sesion.png',
              width: 30,
            ),
          ),
          Container(
            color: const Color(0xFFF5EEC8),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person, size: 50, color: Colors.black),
                const SizedBox(height: 10),
                const Text('Inicio de sesión',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextField(
                  controller: correoController,
                  decoration:
                      const InputDecoration(labelText: 'Correo electrónico'),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: contrasenaController,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: iniciarSesion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.green[200], // Color modificado
                          foregroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text('Ingresar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CrearCuentaScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFA67B5B),
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('¿No tienes cuenta? Crear una aquí'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
