import 'package:flutter/material.dart';
import 'Registro_Exitoso.dart'; // Importa la pantalla de confirmación

class EditarPerfilUsuario extends StatefulWidget {
  const EditarPerfilUsuario({super.key});

  @override
  _EditarPerfilUsuarioState createState() => _EditarPerfilUsuarioState();
}

class _EditarPerfilUsuarioState extends State<EditarPerfilUsuario> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = 'Alan Polanco'; // Valor inicial
  String _telefono = '';
  String _direccion = '';

  void _guardarCambios() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Aquí puedes agregar la lógica para guardar los cambios en tu backend o base de datos

      // Mostrar pantalla de confirmación como un diálogo modal
      showDialog(
        context: context,
        builder: (context) => RegistroExitosoScreen(),
      ).then((_) {
        // Después de cerrar el diálogo, permanece en la pantalla de edición
        setState(() {}); // Actualiza la pantalla si es necesario
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EEC8), // Fondo de color F5EEC8
      appBar: AppBar(
        title: const Text(
          'Editar Perfil',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true, // Centra el título
        backgroundColor: const Color(0xFFA67B5B), // Color de la AppBar
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.pop(context); // Retroceder a la pantalla anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Center(
                // Envuelve el Text en un Center para centrarlo
                child: Text(
                  'Ingrese la información que desea cambiar:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFA67B5B), // Texto en color A67B5B
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _nombre,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  labelStyle:
                      TextStyle(color: Color(0xFFA67B5B)), // Color del label
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFA67B5B)), // Borde inferior
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFFA67B5B)), // Borde inferior al enfocar
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu nombre';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nombre = value!;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _telefono,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  labelStyle:
                      TextStyle(color: Color(0xFFA67B5B)), // Color del label
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFA67B5B)), // Borde inferior
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFFA67B5B)), // Borde inferior al enfocar
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu teléfono';
                  }
                  return null;
                },
                onSaved: (value) {
                  _telefono = value!;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _direccion,
                decoration: const InputDecoration(
                  labelText: 'Dirección',
                  labelStyle:
                      TextStyle(color: Color(0xFFA67B5B)), // Color del label
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFA67B5B)), // Borde inferior
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFFA67B5B)), // Borde inferior al enfocar
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu dirección';
                  }
                  return null;
                },
                onSaved: (value) {
                  _direccion = value!;
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _guardarCambios,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                        0xFFA67B5B), // Fondo del botón en color café
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  child: const Text(
                    'Guardar cambios',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black, // Texto en color negro
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
