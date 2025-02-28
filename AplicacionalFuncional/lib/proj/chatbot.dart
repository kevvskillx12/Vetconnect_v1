import 'package:flutter/material.dart';
import 'package:vetconnectapp/services/chatbot_service.dart';
import 'pantalla_interfaz.dart';

void main() {
  runApp(ChatbotApp());
}

class ChatbotApp extends StatelessWidget {
  const ChatbotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatbotService _chatbotService = ChatbotService();
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _conversacion = [];
  bool _estaCargando = false;

  void _enviarPregunta() async {
    if (_controller.text.isEmpty) return;

    setState(() {
      _estaCargando = true;
      _conversacion.add({"usuario": _controller.text, "bot": ""});
    });

    final respuesta =
        await _chatbotService.obtenerRespuestaIA(_controller.text);

    setState(() {
      _conversacion.last["bot"] = respuesta;
      _estaCargando = false;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5EEC8),
      appBar: AppBar(
        title: Center(
          child: Text(
            "VetTalk",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color(0xFFA67B5B),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => VetConnectScreen()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _conversacion.length,
              itemBuilder: (context, index) {
                final mensaje = _conversacion[index];
                return Column(
                  crossAxisAlignment: mensaje["usuario"] != null
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    if (mensaje["usuario"] != null)
                      _buildMensajeUsuario(mensaje["usuario"]!),
                    if (mensaje["bot"] != null && mensaje["bot"]!.isNotEmpty)
                      _buildMensajeBot(mensaje["bot"]!),
                    SizedBox(height: 10),
                  ],
                );
              },
            ),
          ),
          if (_estaCargando)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: "Escribe tu pregunta...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _enviarPregunta,
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16),
                    backgroundColor: Color(0xFFA67B5B),
                  ),
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMensajeUsuario(String mensaje) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFFA67B5B),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Text(
        mensaje,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildMensajeBot(String mensaje) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Text(
        mensaje,
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}
