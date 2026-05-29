import 'package:app_livros/controller/auth_controller.dart';
import 'package:app_livros/view/theme/cores_app.dart';
import 'package:app_livros/view/widgets/texto_formatado.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaConfirmacaoEmail extends StatelessWidget {
  const TelaConfirmacaoEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();
    final email = auth.emailPendente ?? 'seu e-mail';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.mark_email_unread_outlined,
                size: 80,
                color: CoresApp.primaria,
              ),
              const SizedBox(height: 24),
              const TextoFormatado(
                'Confirme seu e-mail',
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: CoresApp.primaria,
              ),
              const SizedBox(height: 12),
              TextoFormatado(
                'Enviamos um link de confirmação para:\n$email\n\n'
                'Abra o e-mail, clique no link e depois volte aqui para entrar.',
                textAlign: TextAlign.center,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
              if (auth.mensagemErro != null) ...[
                const SizedBox(height: 16),
                Text(
                  auth.mensagemErro!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: auth.mensagemErro!.contains('reenviado') ||
                            auth.mensagemErro!.contains('Reenviamos')
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: auth.processando
                    ? null
                    : () async {
                        await auth.reenviarConfirmacao();
                        if (!context.mounted || auth.mensagemErro != null) {
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'E-mail de confirmação reenviado. Verifique sua caixa de entrada.',
                            ),
                          ),
                        );
                      },
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
                    : const Text('REENVIAR E-MAIL'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: auth.processando ? null : () => auth.irParaLogin(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: CoresApp.secundaria,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('JÁ CONFIRMEI — IR PARA LOGIN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
