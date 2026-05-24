import 'package:app_livros/controller/livro_controller.dart';
import 'package:app_livros/view/widgets/item_livro_lista.dart';
import 'package:app_livros/view/widgets/texto_formatado.dart';
import 'package:flutter/material.dart';

class TelaLidos extends StatefulWidget {
  final LivroController controller;
  const TelaLidos({super.key, required this.controller});

  @override
  State<TelaLidos> createState() => _TelaLidosState();
}

class _TelaLidosState extends State<TelaLidos> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, child) {
        // Filtramos a lista direto do controller
        final lidos = widget.controller.listaLivros
            .where((l) => l.lido)
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Livros lidos'),
            backgroundColor: const Color.fromARGB(255, 66, 13, 76),
            foregroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextoFormatado(
                  'Livros que você já leu!',
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 10),
                TextoFormatado(
                  'Aqui ficam os livros que você já leu, ficam guardados para você se lembrar e também poder avaliar se gostou ou não.',
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                Expanded(
                  child: lidos.isEmpty
                      ? const Center(child: Text('Nenhum livro lido ainda!'))
                      : ListView.builder(
                          itemCount: lidos.length,
                          itemBuilder: (context, index) {
                            return ItemLivroLista(
                              livro: lidos[index],
                              onUpdate: () async {
                                await widget.controller.atualizarLivro(
                                  lidos[index],
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
