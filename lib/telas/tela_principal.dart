import 'dart:ui';

import 'package:app_livros/models/livro.dart';
import 'package:app_livros/telas/tela_cadastro_livro.dart';
import 'package:app_livros/telas/tela_favoritos.dart';
import 'package:app_livros/telas/tela_lidos.dart';
import 'package:app_livros/telas/tela_nao_curtidos.dart';
import 'package:app_livros/widgets/botao_formatado.dart';
import 'package:app_livros/widgets/card_livros.dart';
import 'package:app_livros/widgets/texto_formatado.dart';
import 'package:flutter/material.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  List<Livro> listaLivros = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Biblioteca'),
        backgroundColor: const Color.fromARGB(255, 66, 13, 76),
        foregroundColor: Colors.white,

        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final retorno = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TelaCadastroLivro()),
              );
              if (retorno != null) {
                setState(() {
                  listaLivros.add(retorno);
                });
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
                  const SizedBox(height: 30),

                  // Botão de Cadastrar mais chamativo
                  ElevatedButton.icon(
                    onPressed: () async {
                      final retorno = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TelaCadastroLivro()),
                      );
                      if (retorno != null) {
                        setState(() {
                          listaLivros.add(retorno);
                        });
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

                  const SizedBox(height: 30),

                  SizedBox(
                    height: 250,
                    child: listaLivros.isEmpty
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
                            itemCount: listaLivros.length,
                            itemBuilder: (context, index) {
                              return CardLivros(
                                livro: listaLivros[index],
                                onUpdate: () => setState(() {}),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),

          // "Rodapé" com os botões de categorias
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(
                    255,
                    255,
                    255,
                    255,
                  ).withOpacity(0.3),
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
                      builder: (_) => TelaFavoritos(listaLivros: listaLivros),
                    ),
                  ).then((value) => setState(() {})),
                ),
                BotaoFormatado(
                  icone: Icons.check_circle,
                  legenda: 'Lidos',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TelaLidos(listaLivros: listaLivros),
                    ),
                  ).then((value) => setState(() {})),
                ),
                BotaoFormatado(
                  icone: Icons.thumb_down,
                  legenda: 'Não curtidos',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TelaNaoCurtidos(listaLivros: listaLivros),
                    ),
                  ).then((value) => setState(() {})),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
