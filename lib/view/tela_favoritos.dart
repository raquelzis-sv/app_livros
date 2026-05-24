import 'package:app_livros/controller/livro_controller.dart';
import 'package:app_livros/view/widgets/item_livro_lista.dart';
import 'package:app_livros/view/widgets/texto_formatado.dart';
import 'package:flutter/material.dart';

class TelaFavoritos extends StatefulWidget {
  final LivroController controller;
  const TelaFavoritos({super.key, required this.controller});

  @override
  State<TelaFavoritos> createState() => _TelaFavoritosState();
}

class _TelaFavoritosState extends State<TelaFavoritos> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, child) {
        final favoritos = widget.controller.listaLivros
            .where((l) => l.liked)
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Favoritos'),
            backgroundColor: const Color.fromARGB(255, 66, 13, 76),
            foregroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextoFormatado(
                  'Livros favoritados!',
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 10),
                TextoFormatado(
                  'Livros que você gostou muito e quer ler de novo ou recomendar para alguém!',
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                Expanded(
                  child: favoritos.isEmpty
                      ? const Center(child: Text('Nenhum favorito ainda!'))
                      : ListView.builder(
                          itemCount: favoritos.length,
                          itemBuilder: (context, index) {
                            return ItemLivroLista(
                              livro: favoritos[index],
                              onUpdate: () async {
                                await widget.controller.atualizarLivro(
                                  favoritos[index],
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
