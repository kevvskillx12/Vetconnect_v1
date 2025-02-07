import 'package:flutter/material.dart';
import 'Autenticar_Registro_Servicio.dart'; // Importamos el servicio de registro
import 'Registro_Exitoso.dart'; // Importamos la pantalla de éxito

class CrearCuentaScreen extends StatefulWidget {
  const CrearCuentaScreen({super.key});

  @override
  _CrearCuentaScreenState createState() => _CrearCuentaScreenState();
}

class _CrearCuentaScreenState extends State<CrearCuentaScreen> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();

  bool _isLoading = false; // Para indicar carga en el botón

  Future<void> _registrarUsuario() async {
    if (nombreController.text.isEmpty ||
        correoController.text.isEmpty ||
        telefonoController.text.isEmpty ||
        direccionController.text.isEmpty ||
        contrasenaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: Llenar todos los campos")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final resultado = await AutenticarRegistroServicio.register(
        nombreController.text,
        correoController.text,
        contrasenaController.text,
        int.tryParse(telefonoController.text) ??
            0, // Convertir teléfono a número
        direccionController.text,
      );

      if (resultado["success"] == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RegistroExitosoScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${resultado['message']}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al registrar usuario: $e")),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Creación de cuenta',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: const Color(0xFFA67B5B),
      ),
      backgroundColor: const Color(0xFFF5EEC8),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Por favor ingrese los siguientes datos:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFA67B5B),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
                controller: nombreController,
                decoration:
                    const InputDecoration(labelText: 'Nombre completo')),
            const SizedBox(height: 10),
            TextField(
                controller: correoController,
                decoration:
                    const InputDecoration(labelText: 'Correo electrónico')),
            const SizedBox(height: 10),
            TextField(
                controller: telefonoController,
                decoration:
                    const InputDecoration(labelText: 'Teléfono celular')),
            const SizedBox(height: 10),
            TextField(
                controller: direccionController,
                decoration:
                    const InputDecoration(labelText: 'Dirección de domicilio')),
            const SizedBox(height: 10),
            TextField(
                controller: contrasenaController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _isLoading ? null : _registrarUsuario,
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA67B5B)),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Registrar usuario'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
