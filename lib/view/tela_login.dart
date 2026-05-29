import 'package:app_livros/controller/auth_controller.dart';
import 'package:app_livros/view/tela_cadastro_usuario.dart';
import 'package:app_livros/view/theme/cores_app.dart';
import 'package:app_livros/view/widgets/texto_formatado.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _ocultarSenha = true;

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _entrar() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthController>();
    auth.limparMensagem();
    await auth.entrar(_emailController.text, _senhaController.text);
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.menu_book, size: 72, color: CoresApp.primaria),
                  const SizedBox(height: 16),
                  const TextoFormatado(
                    'Minha Biblioteca',
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: CoresApp.primaria,
                  ),
                  const SizedBox(height: 8),
                  const TextoFormatado(
                    'Entre com seu e-mail e senha',
                    textAlign: TextAlign.center,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                    validator: (valor) {
                      if (valor == null || valor.trim().isEmpty) {
                        return 'Informe o e-mail';
                      }
                      if (!valor.contains('@')) {
                        return 'E-mail inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _senhaController,
                    obscureText: _ocultarSenha,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _ocultarSenha
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() => _ocultarSenha = !_ocultarSenha);
                        },
                      ),
                    ),
                    validator: (valor) {
                      if (valor == null || valor.isEmpty) {
                        return 'Informe a senha';
                      }
                      if (valor.length < 6) {
                        return 'Mínimo de 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  if (auth.mensagemErro != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      auth.mensagemErro!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: auth.processando ? null : _entrar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CoresApp.primaria,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: auth.processando
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('ENTRAR'),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: auth.processando
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const TelaCadastroUsuario(),
                              ),
                            );
                          },
                    child: const Text(
                      'Não tem conta? Cadastre-se',
                      style: TextStyle(color: CoresApp.secundaria),
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
