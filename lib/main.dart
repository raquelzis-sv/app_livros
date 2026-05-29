import 'package:app_livros/controller/auth_controller.dart';
import 'package:app_livros/controller/livro_controller.dart';
import 'package:app_livros/service/auth_service.dart';
import 'package:app_livros/service/database_service.dart';
import 'package:app_livros/service/livro_service.dart';
import 'package:app_livros/view/tela_auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await DatabaseService.inicializar();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthController(AuthService())..inicializar(),
        ),
        ChangeNotifierProvider(
          create: (_) => LivroController(LivroService()),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaAuthGate(),
    );
  }
}
