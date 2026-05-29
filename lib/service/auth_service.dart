import 'package:supabase_flutter/supabase_flutter.dart';

class EmailNaoConfirmadoException implements Exception {
  final String message;

  const EmailNaoConfirmadoException([
    this.message = 'Confirme seu e-mail antes de entrar.',
  ]);
}

class AuthService {
  final SupabaseClient _client;

  AuthService([SupabaseClient? client])
      : _client = client ?? Supabase.instance.client;

  Session? get sessaoAtual => _client.auth.currentSession;

  User? get usuarioAtual => _client.auth.currentUser;

  Stream<AuthState> get onAuthStateChange => _client.auth.onAuthStateChange;

  bool get emailConfirmado {
    final user = usuarioAtual;
    return user != null && user.emailConfirmedAt != null;
  }

  Future<void> cadastrar(String email, String senha) async {
    await _client.auth.signUp(email: email.trim(), password: senha);
    await _client.auth.signOut();
  }

  Future<void> entrar(String email, String senha) async {
    final response = await _client.auth.signInWithPassword(
      email: email.trim(),
      password: senha,
    );

    final user = response.user;
    if (user != null && user.emailConfirmedAt == null) {
      await _client.auth.signOut();
      throw const EmailNaoConfirmadoException();
    }
  }

  Future<void> sair() async {
    await _client.auth.signOut();
  }

  Future<void> reenviarConfirmacaoEmail(String email) async {
    await _client.auth.resend(
      type: OtpType.signup,
      email: email.trim(),
    );
  }
}
