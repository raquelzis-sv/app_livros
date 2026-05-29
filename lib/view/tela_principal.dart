import 'dart:ui';

import 'package:app_livros/controller/auth_controller.dart';
import 'package:app_livros/controller/livro_controller.dart';
import 'package:app_livros/view/theme/cores_app.dart';
import 'package:app_livros/view/tela_cadastro_livro.dart';
import 'package:app_livros/view/tela_favoritos.dart';
import 'package:app_livros/view/tela_lidos.dart';
import 'package:app_livros/view/tela_nao_curtidos.dart';
import 'package:app_livros/view/widgets/botao_formatado.dart';
import 'package:app_livros/view/widgets/card_livros.dart';
import 'package:app_livros/view/widgets/texto_formatado.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LivroController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Biblioteca'),
        backgroundColor: CoresApp.primaria,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () async {
              await context.read<AuthController>().sair();
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final retorno = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TelaCadastroLivro()),
              );
              if (retorno != null && context.mounted) {
                await controller.adicionarLivro(retorno);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextoFormatado(
                    'Bem-vindo à sua biblioteca!',
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),
                  TextoFormatado(
                    'Seu espaço privado para organizar e compartilhar seus livros. Aqui você pode adicionar e cadastrar seus livros, marcar os que já leu e indicar os seus favoritos!',
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final retorno = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TelaCadastroLivro(),
                        ),
                      );
                      if (retorno != null && context.mounted) {
                        await controller.adicionarLivro(retorno);
                      }
                    },
                    icon: const Icon(Icons.library_add),
                    label: const Text('CADASTRAR NOVO LIVRO'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 66, 13, 76),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 300,
                    width: 600,
                    child: controller.carregando
                        ? const Center(child: CircularProgressIndicator())
                        : controller.listaLivros.isEmpty
                        ? const Center(child: Text('Nenhum livro cadastrado.'))
                        : PageView.builder(
                            scrollBehavior: const ScrollBehavior().copyWith(
                              dragDevices: {
                                PointerDeviceKind.touch,
                                PointerDeviceKind.mouse,
                                PointerDeviceKind.trackpad,
                              },
                            ),
                            controller: PageController(viewportFraction: 0.8),
                            itemCount: controller.listaLivros.length,
                            itemBuilder: (context, index) {
                              final livro = controller.listaLivros[index];
                              return CardLivros(
                                livro: livro,
                                onUpdate: () async {
                                  await controller.atualizarLivro(livro);
                                },
                                onDelete: () async {
                                  await controller.deletarLivro(livro.id!);
                                },
                                onEdit: () async {
                                  final retorno = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          TelaCadastroLivro(livro: livro),
                                    ),
                                  );
                                  if (retorno != null && context.mounted) {
                                    await controller.atualizarLivro(retorno);
                                  }
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 255, 255, 255)
                      .withValues(alpha: 0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BotaoFormatado(
                  icone: Icons.favorite_border,
                  legenda: 'Favoritos',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TelaFavoritos(),
                    ),
                  ),
                ),
                BotaoFormatado(
                  icone: Icons.check_circle,
                  legenda: 'Lidos',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TelaLidos()),
                  ),
                ),
                BotaoFormatado(
                  icone: Icons.thumb_down,
                  legenda: 'Não curtidos',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TelaNaoCurtidos(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
