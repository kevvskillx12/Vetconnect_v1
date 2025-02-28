import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vetconnectapp/proj/chatbot.dart';
import 'Agendar_Cita.dart';
import 'Informacion_Usuario.dart';
import 'Buscar_Veterinario.dart';
import 'Registrar_mascota.dart';
import 'Configuracion.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Informacion_mascota.dart';
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VetConnect',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const VetConnectScreen(),
    );
  }
}

class VetConnectScreen extends StatefulWidget {
  const VetConnectScreen({super.key});

  @override
  State<VetConnectScreen> createState() => _VetConnectScreenState();
}

class _VetConnectScreenState extends State<VetConnectScreen> {
  bool hasUpcomingAppointments = false;
  bool isExpanded = false;
  List<String> upcomingAppointments = [];
  late ScrollController _scrollController;
  String correo = "";
  String contrasena = "";
  int usuarioId = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadCitas();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      correo = prefs.getString('correo') ?? "";
      contrasena = prefs.getString('contrasena') ?? "";
      usuarioId = prefs.getInt('usuarioId') ?? 0;
    });
    print("UsuarioId: $usuarioId");
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreCitas();
    }
  }

  void _loadCitas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> citasAlmacenadas = prefs.getStringList('citas') ?? [];
    List<String> citasFiltradas = [];

    for (String citaStr in citasAlmacenadas) {
      try {
        // Solo intentamos decodificar si la cadena parece ser un JSON (por ejemplo, comienza con '{')
        if (citaStr.trim().startsWith('{')) {
          Map<String, dynamic> citaJson = json.decode(citaStr);
          if (citaJson["usuarioId"] == usuarioId) {
            citasFiltradas.add(citaJson["descripcion"] ?? "");
          }
        } else {
          // Si la cadena no es JSON, se omite y se imprime un aviso en consola
          print("La cita almacenada no es un JSON válido: $citaStr");
        }
      } catch (e) {
        print("Error al decodificar la cita: $e. Cita: $citaStr");
      }
    }

    setState(() {
      upcomingAppointments = citasFiltradas;
      hasUpcomingAppointments = citasFiltradas.isNotEmpty;
    });
  }

  void _loadMoreCitas() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      upcomingAppointments.addAll(List.generate(
          5,
          (index) =>
              'Cita agendada para la fecha: 2025-02-05 a las 15:30 en: Veterinaria ${upcomingAppointments.length + index + 1}'));
    });
  }

  void _agendarCita(Map<String, dynamic> cita) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> citasAlmacenadas = prefs.getStringList('citas') ?? [];

    // Verifica si la cita ya existe
    bool existe = citasAlmacenadas.any((citaStr) {
      try {
        Map<String, dynamic> existing = json.decode(citaStr);
        return existing['fechaHora'] == cita['fechaHora'] &&
            existing['usuarioId'] == usuarioId;
      } catch (e) {
        // Si la cadena no es JSON, se ignora
        return false;
      }
    });

    if (!existe) {
      String citaString = json.encode(cita);
      citasAlmacenadas.add(citaString);
      await prefs.setStringList('citas', citasAlmacenadas);
    }

    _loadCitas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: Text(
                '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.dog, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        InformacionMascota(usuarioId: usuarioId),
                  ),
                );
              },
            ),
          ],
        ),
        backgroundColor: const Color(0xFFA67B5B),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => _showMenu(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondovetconnectconhuellitas.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Bienvenido a VetConnect',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFA67B5B),
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 30),
                    GridView.count(
                      crossAxisCount:
                          MediaQuery.of(context).size.width < 600 ? 2 : 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildCard(
                          FontAwesomeIcons.user,
                          'Información del usuario',
                          MediaQuery.of(context).size.width,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    InformacionUsuario(usuarioId: usuarioId),
                              ),
                            );
                          },
                        ),
                        _buildCard(
                          FontAwesomeIcons.calendar,
                          'Agendar cita',
                          MediaQuery.of(context).size.width,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AgendarCita(
                                  onCitaAgendada: _agendarCita,
                                  usuarioId: usuarioId,
                                  tipoUsuario: 'Cliente',
                                ),
                              ),
                            );
                          },
                        ),
                        _buildCard(
                          FontAwesomeIcons.paw,
                          'Registrar a mi mascota',
                          MediaQuery.of(context).size.width,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistrarMascotaScreen(
                                    usuarioId: usuarioId),
                              ),
                            );
                          },
                        ),
                        _buildCard(
                          FontAwesomeIcons.search,
                          'Buscar veterinario',
                          MediaQuery.of(context).size.width,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BuscarVeterinario(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildUpcomingAppointmentsWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingAppointmentsWidget() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isExpanded ? MediaQuery.of(context).size.height * 0.4 : 50,
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFA67B5B),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    hasUpcomingAppointments
                        ? 'Tienes citas próximas'
                        : 'No tienes citas próximas',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.white,
                    size: 26,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Expanded(
              child: hasUpcomingAppointments
                  ? NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                          _loadMoreCitas();
                        }
                        return true;
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: upcomingAppointments.length,
                        padding: const EdgeInsets.only(bottom: 10),
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 3),
                                    child: Icon(Icons.calendar_today,
                                        color: Colors.brown, size: 22),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          upcomingAppointments[index],
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15.5,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Divider(
                                          height: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'No tienes citas próximas\nAgenda una nueva cita desde el menú',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 15.5,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
            ),
        ],
      ),
    );
  }

  Widget _buildCard(
      IconData icon, String text, double width, VoidCallback onTap) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.green[200],
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: width * 0.08, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: width * 0.035,
                color: Colors.white,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    final RenderBox appBarRenderBox = context.findRenderObject() as RenderBox;
    final Offset offset = appBarRenderBox.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + kToolbarHeight,
        offset.dx + appBarRenderBox.size.width,
        offset.dy + appBarRenderBox.size.height,
      ),
      items: [
        PopupMenuItem(
          value: 'configuracion',
          child: const ListTile(
            leading: Icon(Icons.settings, size: 20),
            title: Text('Configuración'),
          ),
        ),
        PopupMenuItem(
          value: 'Chatbot',
          child: const ListTile(
            leading: Icon(FontAwesomeIcons.paw, size: 20),
            title: Text('Chatbot'),
          ),
        ),
      ],
    ).then((value) {
      if (value == 'configuracion') {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ConfiguracionScreen()),
        );
      } else if (value == 'Chatbot') {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatbotApp()),
        );
      }
    });
  }
}
