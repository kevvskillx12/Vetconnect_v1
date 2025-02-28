import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para inputFormatters
import 'Autenticar_Registro_Servicio.dart';
import 'Registro_Exitoso.dart';

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
  final TextEditingController confirmarContrasenaController =
      TextEditingController();

  bool _isObscure = true;
  bool _isLoading = false;

  Future<void> _registrarUsuario() async {
    // Validación de campos vacíos
    if (nombreController.text.isEmpty ||
        correoController.text.isEmpty ||
        telefonoController.text.isEmpty ||
        direccionController.text.isEmpty ||
        contrasenaController.text.isEmpty ||
        confirmarContrasenaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: Todos los campos son requeridos")),
      );
      return;
    }

    // Validación de teléfono: debe tener 9 dígitos
    if (telefonoController.text.length < 9) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("El teléfono debe tener al menos 9 dígitos")),
      );
      return;
    }

    // Validación del correo: verificar dominios permitidos
    final allowedDomains = ['@gmail.com', '@outlook.com', '@hotmail.com'];
    bool emailValid = allowedDomains.any((domain) =>
        correoController.text.trim().toLowerCase().endsWith(domain));
    if (!emailValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                "Por favor ingrese un correo válido (@gmail, @outlook, @hotmail)")),
      );
      return;
    }

    // Validación de que las contraseñas coincidan
    if (contrasenaController.text != confirmarContrasenaController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Las contraseñas no coinciden")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final resultado = await AutenticarRegistroServicio.register(
        nombreController.text,
        correoController.text,
        contrasenaController.text,
        int.tryParse(telefonoController.text) ?? 0,
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
        SnackBar(content: Text("Error de conexión: ${e.toString()}")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Creación de cuenta',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFA67B5B),
      ),
      backgroundColor: const Color(0xFFF5EEC8),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Por favor ingrese los siguientes datos:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30), //aumentado para el espacio
                    _buildTextField(
                      controller: nombreController,
                      label: 'Nombre completo',
                      inputType: TextInputType.name,
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: correoController,
                      label: 'Correo electrónico',
                      inputType: TextInputType.emailAddress,
                      // Puedes agregar un helperText aquí si lo deseas
                      // helperText: 'Ejemplo: usuario@gmail.com',
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: telefonoController,
                      label: 'Teléfono (ejemplo: 992793021)',
                      inputType: TextInputType.phone,
                      formatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(
                            9), // Limita a 9 caracteres
                      ],
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: direccionController,
                      label: 'Dirección de domicilio',
                      inputType: TextInputType.streetAddress,
                    ),
                    const SizedBox(height: 15),
                    // Campo de contraseña
                    TextField(
                      controller: contrasenaController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          onPressed: () =>
                              setState(() => _isObscure = !_isObscure),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFA67B5B)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Campo para confirmar contraseña
                    TextField(
                      controller: confirmarContrasenaController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        labelText: 'Confirmar contraseña',
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          onPressed: () =>
                              setState(() => _isObscure = !_isObscure),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFA67B5B)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _registrarUsuario,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA67B5B),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Registrar Usuario',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? inputType,
    List<TextInputFormatter>? formatters,
  }) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      inputFormatters: formatters,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFA67B5B)),
        ),
      ),
    );
  }
}
