import 'package:flutter/material.dart';
import 'package:vetconnectapp/services/cita_service.dart';
import 'package:vetconnectapp/services/mascota_service.dart';
import 'package:vetconnectapp/services/veterinario_service.dart';
import 'Registrar_mascota.dart';
import 'pantalla_interfaz.dart';

class AgendarCita extends StatefulWidget {
  final Function(Map<String, dynamic>) onCitaAgendada;
  final int usuarioId;
  final String tipoUsuario;

  const AgendarCita({
    Key? key,
    required this.onCitaAgendada,
    required this.usuarioId,
    required this.tipoUsuario,
  }) : super(key: key);

  @override
  _AgendarCitaState createState() => _AgendarCitaState();
}

class _AgendarCitaState extends State<AgendarCita> {
  final TextEditingController veterinarioIdController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();
  final TextEditingController horaController = TextEditingController();

  bool _isLoading = false;
  bool _dialogMostrado = false;
  bool _isLoadingVeterinarios = false;
  final CitaService _citaService = CitaService();
  final MascotaService _mascotaService = MascotaService();
  final VeterinarioService _veterinarioService = VeterinarioService();
  List<dynamic> mascotas = [];
  List<dynamic> filteredVeterinarios = [];

  @override
  void initState() {
    super.initState();
    if (widget.tipoUsuario == 'Cliente') {
      _cargarMascotas();
    }
  }

  Future<void> _cargarMascotas() async {
    setState(() => _isLoading = true);
    try {
      mascotas = await _mascotaService.getMascotasByUsuarioId(widget.usuarioId);
      if (mascotas.isEmpty && !_dialogMostrado) {
        _dialogMostrado = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _mostrarDialogoSinMascota(context);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar las mascotas: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _mostrarDialogoSinMascota(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('No tienes mascotas agregadas'),
          content: const Text('¿Quieres ir a registrar una mascota?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistrarMascotaScreen(
                      usuarioId: widget.usuarioId,
                    ),
                  ),
                );
              },
              child: const Text('Sí'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => VetConnectScreen()),
                );
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  void _agendarCita(BuildContext context) async {
    if (veterinarioIdController.text.isEmpty ||
        fechaController.text.isEmpty ||
        horaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete todos los campos')),
      );
      return;
    }

    String fechaHora = "${fechaController.text}T${horaController.text}:00";

    int? mascotaId = widget.tipoUsuario == 'Cliente' && mascotas.isNotEmpty
        ? mascotas[0]['mascotaId']
        : null;

    final citaData = {
      "fechaHora": fechaHora,
      "usuarioId": widget.usuarioId,
      "veterinarioId": veterinarioIdController.text,
      "mascotaId": mascotaId,
      "estado": "Pendiente",
    };

    setState(() => _isLoading = true);

    try {
      bool success = await _citaService.crearCita(citaData);
      if (success) {
        String descripcion =
            'Cita agendada para la fecha ${fechaController.text} a las ${horaController.text} en ${veterinarioIdController.text}. Estado: Pendiente.';

        Map<String, dynamic> citaJson = {
          "fechaHora": fechaHora,
          "usuarioId": widget.usuarioId,
          "veterinarioId": veterinarioIdController.text,
          "mascotaId": mascotaId,
          "estado": "Pendiente",
          "descripcion": descripcion,
        };

        // Opcional: guardar información adicional de la cita
        await _citaService.guardarCita(citaJson);
        widget.onCitaAgendada(citaJson);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cita agendada exitosamente')),
        );

        // Mostrar el mensaje de que la cita está pendiente
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Cita Pendiente'),
              content: const Text(
                  'Su cita por el momento está pendiente, en algún momento tendremos actualizaciones.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Cierra el diálogo
                    Navigator.pop(
                        context); // Cierra la pantalla de agendar cita
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
        );
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

  @override
  Widget build(BuildContext context) {
    // Caso en el que el usuario es Cliente y no tiene mascotas
    if (widget.tipoUsuario == 'Cliente' && !_isLoading && mascotas.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Agendar Cita',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFA67B5B),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
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
          child: const Center(
            child: Text(
              'No tienes mascotas registradas.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agendar Cita',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFA67B5B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
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
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          controller: veterinarioIdController,
                          decoration: InputDecoration(
                            labelText: 'Nombre de la veterinaria',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              setState(() => filteredVeterinarios = []);
                              return;
                            }
                            setState(() => _isLoadingVeterinarios = true);
                            try {
                              List<dynamic> resultados =
                                  await _veterinarioService
                                      .buscarVeterinarios(value);
                              setState(() => filteredVeterinarios = resultados);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Error buscando veterinarias: $e')),
                              );
                            } finally {
                              setState(() => _isLoadingVeterinarios = false);
                            }
                          },
                        ),
                        if (_isLoadingVeterinarios)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: CircularProgressIndicator(),
                          ),
                        if (filteredVeterinarios.isNotEmpty)
                          Container(
                            constraints: const BoxConstraints(maxHeight: 200),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredVeterinarios.length,
                              itemBuilder: (context, index) {
                                final vet = filteredVeterinarios[index];
                                return ListTile(
                                  title: Text(vet['nombreCompleto']),
                                  subtitle: Text(vet['veterinarioId']),
                                  onTap: () {
                                    setState(() {
                                      veterinarioIdController.text =
                                          vet['veterinarioId'];
                                      filteredVeterinarios = [];
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        const SizedBox(height: 30),
                        _buildDateField(fechaController, context),
                        const SizedBox(height: 30),
                        _buildTimeField(horaController, context),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed:
                              _isLoading ? null : () => _agendarCita(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFA67B5B),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 55, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
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
                ),
              ),
      ),
    );
  }
}
