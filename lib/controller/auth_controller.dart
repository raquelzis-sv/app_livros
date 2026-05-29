import 'dart:async';

import 'package:app_livros/model/auth_estado.dart';
import 'package:app_livros/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends ChangeNotifier {
  final AuthService _service;

  AuthEstado estado = AuthEstado.carregando;
  bool processando = false;
  String? mensagemErro;
  String? emailPendente;

  StreamSubscription<AuthState>? _authSubscription;

  AuthController(this._service);

  Future<void> inicializar() async {
    await _sincronizarEstado();
    _authSubscription = _service.onAuthStateChange.listen((_) {
      _sincronizarEstado();
    });
  }

  Future<void> cadastrar(String email, String senha) async {
    processando = true;
    mensagemErro = null;
    notifyListeners();

    try {
      await _service.cadastrar(email, senha);
      emailPendente = email.trim();
      estado = AuthEstado.aguardandoConfirmacaoEmail;
    } on AuthException catch (e) {
      mensagemErro = _mensagemAuth(e);
    } catch (e) {
      mensagemErro = 'Não foi possível criar a conta. Tente novamente.';
    } finally {
      processando = false;
      notifyListeners();
    }
  }

  Future<void> entrar(String email, String senha) async {
    processando = true;
    mensagemErro = null;
    notifyListeners();

    try {
      await _service.entrar(email, senha);
      emailPendente = null;
      estado = AuthEstado.autenticado;
    } on EmailNaoConfirmadoException {
      emailPendente = email.trim();
      estado = AuthEstado.aguardandoConfirmacaoEmail;
      mensagemErro = 'Confirme seu e-mail antes do primeiro acesso.';
    } on AuthException catch (e) {
      mensagemErro = _mensagemAuth(e);
    } catch (e) {
      mensagemErro = 'Não foi possível entrar. Tente novamente.';
    } finally {
      processando = false;
      notifyListeners();
    }
  }

  Future<void> sair() async {
    processando = true;
    notifyListeners();

    try {
      await _service.sair();
      emailPendente = null;
      estado = AuthEstado.naoAutenticado;
    } finally {
      processando = false;
      notifyListeners();
    }
  }

  Future<void> reenviarConfirmacao() async {
    final email = emailPendente;
    if (email == null || email.isEmpty) {
      mensagemErro = 'Informe o e-mail da conta.';
      notifyListeners();
      return;
    }

    processando = true;
    mensagemErro = null;
    notifyListeners();

    try {
      await _service.reenviarConfirmacaoEmail(email);
      mensagemErro = null;
    } on AuthException catch (e) {
      mensagemErro = _mensagemAuth(e);
    } catch (e) {
      mensagemErro = 'Não foi possível reenviar o e-mail.';
    } finally {
      processando = false;
      notifyListeners();
    }
  }

  void irParaLogin() {
    emailPendente = null;
    mensagemErro = null;
    estado = AuthEstado.naoAutenticado;
    notifyListeners();
  }

  void limparMensagem() {
    mensagemErro = null;
    notifyListeners();
  }

  Future<void> _sincronizarEstado() async {
    final session = _service.sessaoAtual;
    final user = _service.usuarioAtual;

    if (session == null || user == null) {
      if (estado != AuthEstado.aguardandoConfirmacaoEmail) {
        estado = AuthEstado.naoAutenticado;
      }
    } else if (user.emailConfirmedAt == null) {
      emailPendente ??= user.email;
      await _service.sair();
      estado = AuthEstado.aguardandoConfirmacaoEmail;
    } else {
      emailPendente = null;
      estado = AuthEstado.autenticado;
    }

    notifyListeners();
  }

  String _mensagemAuth(AuthException e) {
    final msg = e.message.toLowerCase();

    if (msg.contains('email not confirmed') ||
        msg.contains('email_not_confirmed')) {
      return 'Confirme seu e-mail antes do primeiro acesso.';
    }
    if (msg.contains('invalid login credentials') ||
        msg.contains('invalid_credentials')) {
      return 'E-mail ou senha incorretos.';
    }
    if (msg.contains('user already registered')) {
      return 'Este e-mail já está cadastrado.';
    }
    if (msg.contains('password') && msg.contains('least')) {
      return 'A senha deve ter pelo menos 6 caracteres.';
    }

    return e.message;
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
