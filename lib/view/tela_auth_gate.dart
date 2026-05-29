import 'package:app_livros/controller/auth_controller.dart';
import 'package:app_livros/controller/livro_controller.dart';
import 'package:app_livros/model/auth_estado.dart';
import 'package:app_livros/view/tela_confirmacao_email.dart';
import 'package:app_livros/view/tela_login.dart';
import 'package:app_livros/view/tela_principal.dart';
import 'package:app_livros/view/theme/cores_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaAuthGate extends StatefulWidget {
  const TelaAuthGate({super.key});

  @override
  State<TelaAuthGate> createState() => _TelaAuthGateState();
}

class _TelaAuthGateState extends State<TelaAuthGate> {
  AuthEstado? _estadoAnterior;

  void _reagirMudancaEstado(AuthEstado estado) {
    final livroController = context.read<LivroController>();

    if (estado == AuthEstado.autenticado &&
        _estadoAnterior != AuthEstado.autenticado) {
      livroController.carregarLivros();
    }

    if (_estadoAnterior == AuthEstado.autenticado &&
        estado != AuthEstado.autenticado) {
      livroController.limpar();
    }

    _estadoAnterior = estado;
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();
    _reagirMudancaEstado(auth.estado);

    switch (auth.estado) {
      case AuthEstado.carregando:
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(color: CoresApp.primaria),
          ),
        );
      case AuthEstado.autenticado:
        return const TelaPrincipal();
      case AuthEstado.aguardandoConfirmacaoEmail:
        return const TelaConfirmacaoEmail();
      case AuthEstado.naoAutenticado:
        return const TelaLogin();
    }
  }
}
