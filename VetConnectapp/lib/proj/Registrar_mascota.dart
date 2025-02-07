import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Registro_Exitoso_RegistrarMascota.dart'; // Importa la pantalla de éxito

class RegistrarMascotaScreen extends StatefulWidget {
  @override
  _RegistrarMascotaScreenState createState() => _RegistrarMascotaScreenState();
}

class _RegistrarMascotaScreenState extends State<RegistrarMascotaScreen> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController tipoController = TextEditingController();
  final TextEditingController razaController = TextEditingController();
  final TextEditingController fechaNacimientoController =
      TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController infoMedicaController = TextEditingController();
  final TextEditingController usuarioIdController = TextEditingController();

  bool _isLoading = false;

  Future<void> _registrarMascota() async {
    if (nombreController.text.isEmpty ||
        tipoController.text.isEmpty ||
        razaController.text.isEmpty ||
        fechaNacimientoController.text.isEmpty ||
        pesoController.text.isEmpty ||
        usuarioIdController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete todos los campos')),
      );
      return;
    }

    final mascotaData = {
      "Nombre": nombreController.text,
      "Tipo": tipoController.text,
      "Raza": razaController.text,
      "FechaNacimiento": fechaNacimientoController.text,
      "Peso": double.tryParse(pesoController.text) ?? 0.0,
      "InformacionMedica": infoMedicaController.text,
      "UsuarioId": int.tryParse(usuarioIdController.text) ?? 0,
    };

    setState(() => _isLoading = true);

    final response = await http.post(
      Uri.parse('http://www.probando.somee.com/api/Mascota'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(mascotaData),
    );

    setState(() => _isLoading = false);

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const RegistroExitosoRegistrarMascotaScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al registrar la mascota')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EEC8),
      appBar: AppBar(
        title: const Text(
          'Registrar Mascota',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFA67B5B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildTextField(nombreController, 'Nombre'),
            const SizedBox(height: 15),
            _buildTextField(tipoController, 'Tipo'),
            const SizedBox(height: 15),
            _buildTextField(razaController, 'Raza'),
            const SizedBox(height: 15),
            _buildTextField(fechaNacimientoController, 'Fecha de Nacimiento'),
            const SizedBox(height: 15),
            _buildTextField(pesoController, 'Peso', isNumeric: true),
            const SizedBox(height: 15),
            _buildTextField(infoMedicaController, 'Información Médica'),
            const SizedBox(height: 15),
            _buildTextField(usuarioIdController, 'ID del Usuario',
                isNumeric: true),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: _isLoading ? null : _registrarMascota,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA67B5B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                minimumSize: const Size(200, 50), //ancho maximo y mas alto
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Registrar Mascota'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumeric = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      ),
    );
  }
}
