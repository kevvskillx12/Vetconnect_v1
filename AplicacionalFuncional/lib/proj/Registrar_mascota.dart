import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrarMascotaScreen extends StatefulWidget {
  final int usuarioId; // Agregamos el parámetro usuarioId

  const RegistrarMascotaScreen({super.key, required this.usuarioId});

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

  bool _isLoading = false;

  Future<void> _registrarMascota() async {
    if (nombreController.text.isEmpty ||
        tipoController.text.isEmpty ||
        razaController.text.isEmpty ||
        fechaNacimientoController.text.isEmpty ||
        pesoController.text.isEmpty) {
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
      "UsuarioId": widget.usuarioId, // Usamos el usuarioId que recibimos
    };

    // Imprime los datos que se van a enviar
    print("Datos que se van a enviar: ${json.encode(mascotaData)}");

    setState(() => _isLoading = true);

    final response = await http.post(
      Uri.parse('http://www.probando.somee.com/api/Mascota'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(mascotaData),
    );

    setState(() => _isLoading = false);

    // Imprime el código de estado y el cuerpo de la respuesta
    print("Código de estado: ${response.statusCode}");
    print("Cuerpo de la respuesta: ${response.body}");

    if (response.statusCode == 201) {
      // Muestra la notificación de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Mascota registrada exitosamente!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al registrar la mascota')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        fechaNacimientoController.text =
            "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registrar Mascota',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFA67B5B),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondovetconnectconhuellitas.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          // Agregar ScrollView aquí
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _buildTextField(nombreController, 'Nombre'),
              const SizedBox(height: 15),
              _buildTextField(tipoController, 'Tipo de mascota'),
              const SizedBox(height: 15),
              _buildTextField(razaController, 'Raza'),
              const SizedBox(height: 15),
              _buildDateField(fechaNacimientoController, 'Fecha de Nacimiento'),
              const SizedBox(height: 15),
              _buildTextField(pesoController, 'Peso', isNumeric: true),
              const SizedBox(height: 15),
              _buildTextField(infoMedicaController, 'Observaciones Médicas'),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: _isLoading ? null : _registrarMascota,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA67B5B),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize: const Size(200, 50),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Registrar Mascota'),
              ),
            ],
          ),
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

  Widget _buildDateField(TextEditingController controller, String label) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          ),
        ),
      ),
    );
  }
}
