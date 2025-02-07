import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Pantalla_interfaz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Agendar_Cita extends StatefulWidget {
  final Function(String) onCitaAgendada;

  const Agendar_Cita({super.key, required this.onCitaAgendada});

  @override
  _Agendar_CitaState createState() => _Agendar_CitaState();
}

class _Agendar_CitaState extends State<Agendar_Cita> {
  final TextEditingController usuarioIdController = TextEditingController();
  final TextEditingController veterinarioIdController = TextEditingController();
  final TextEditingController mascotaIdController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();
  final TextEditingController horaController = TextEditingController();

  bool _isLoading = false;

  Future<bool> createCita(Map<String, dynamic> citaData) async {
    final response = await http.post(
      Uri.parse('http://www.probando.somee.com/api/Cita'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(citaData),
    );

    return response.statusCode == 200;
  }

  void _agendarCita(BuildContext context) async {
    if (usuarioIdController.text.isEmpty ||
        veterinarioIdController.text.isEmpty ||
        mascotaIdController.text.isEmpty ||
        fechaController.text.isEmpty ||
        horaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete todos los campos')),
      );
      return;
    }

    String fechaHora = "${fechaController.text}T${horaController.text}:00";

    final citaData = {
      "fechaHora": fechaHora,
      "usuarioId": int.parse(usuarioIdController.text),
      "veterinarioId": veterinarioIdController.text,
      "mascotaId": int.parse(mascotaIdController.text),
      "estado": "Pendiente",
    };

    setState(() => _isLoading = true);

    try {
      bool success = await createCita(citaData);
      if (success) {
        // Guardamos la cita en SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String> citas = prefs.getStringList('citas') ?? [];
        citas.add(
            'Cita agendada para la fecha: ${fechaController.text} a las ${horaController.text} en: ${veterinarioIdController.text}');
        prefs.setStringList('citas', citas);

        widget.onCitaAgendada(citas.last);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cita agendada exitosamente')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al agendar la cita')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al agendar la cita: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar Cita'),
        centerTitle: true,
        backgroundColor: const Color(0xFFA67B5B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: const Color(0xFFF5EEC8),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTextField(usuarioIdController, 'ID del Usuario', true),
            const SizedBox(height: 20),
            // Cambiado: "ID del Veterinario" => "Nombre del veterinario"
            _buildTextField(
                veterinarioIdController, 'Nombre del veterinario', false),
            const SizedBox(height: 20),
            _buildTextField(mascotaIdController, 'ID de la Mascota', true),
            const SizedBox(height: 20),
            _buildDateField(fechaController, context),
            const SizedBox(height: 20),
            _buildTimeField(horaController, context),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isLoading ? null : () => _agendarCita(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA67B5B),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(
                      color: Color.fromARGB(255, 255, 255, 255))
                  : const Text(
                      'Agendar cita',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, bool isNumeric) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
    );
  }

  Widget _buildDateField(
      TextEditingController controller, BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Fecha (YYYY-MM-DD)',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: const Icon(Icons.calendar_today, color: Colors.black54),
      ),
      readOnly: true,
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          setState(() => controller.text = pickedDate.toString().split(' ')[0]);
        }
      },
    );
  }

  Widget _buildTimeField(
      TextEditingController controller, BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Hora (HH:MM)',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: const Icon(Icons.access_time, color: Colors.black54),
      ),
      readOnly: true,
      onTap: () async {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          setState(() => controller.text =
              "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}");
        }
      },
    );
  }
}
