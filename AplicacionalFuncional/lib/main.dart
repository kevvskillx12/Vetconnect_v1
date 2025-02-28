import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'proj/Inicio_sesion.dart';
import 'proj/notification_manager.dart';
import 'proj/Agendar_Cita.dart';

// Handler para mensajes en background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Mensaje en background: ${message.messageId}");

  if (message.notification != null) {
    NotificationManager.showCustomNotification(
      message.notification?.title ?? 'Nueva cita',
      message.notification?.body ?? 'Tienes una nueva notificación',
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    print("Firebase inicializado correctamente");
  } catch (e) {
    print("Error al inicializar Firebase: $e");
  }

  await NotificationManager.initialize();

  // Configurar FCM
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Solicitar permisos para recibir notificaciones
  NotificationSettings settings = await messaging.requestPermission();

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('Permisos de notificación autorizados');
  } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
    print('Permisos de notificación denegados');
  }

  // Obtener el token de registro
  String? token = await messaging.getToken();
  print("FCM Token: $token");
  // Enviar token a tu servidor aquí

  // Registrar handler para mensajes en background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Configurar listener para mensajes en primer plano
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    NotificationManager.showCustomNotification(
      message.notification?.title ?? 'Nueva notificación',
      message.notification?.body ?? 'Tienes una nueva actualización',
    );
  });

  // Bloquear orientación vertical
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VetConnect',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/agendar': (context) => AgendarCita(
              usuarioId: 1, // Obtener de tu sistema de autenticación
              tipoUsuario: 'Cliente',
              onCitaAgendada: (cita) {
                NotificationManager.showCustomNotification(
                  'Cita Agendada!',
                  'Fecha: ${cita['fechaHora'].split('T')[0]} Hora: ${cita['fechaHora'].split('T')[1]}',
                );
              },
            ),
      },
    );
  }
}

// Splash Screen (se mantiene igual)
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/fondovetconnectconhuellitas.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Image.asset(
              'assets/vetconnectlogo.png',
              width: 200,
              height: 200,
            ),
          ),
        ],
      ),
    );
  }
}
