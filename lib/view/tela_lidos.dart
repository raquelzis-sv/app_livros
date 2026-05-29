import 'package:app_livros/controller/livro_controller.dart';
import 'package:app_livros/view/widgets/item_livro_lista.dart';
import 'package:app_livros/view/widgets/texto_formatado.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaLidos extends StatelessWidget {
  const TelaLidos({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LivroController>();
    final lidos = controller.livrosLidos;

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
                        final livro = lidos[index];
                        return ItemLivroLista(
                          livro: livro,
                          onUpdate: () async {
                            await controller.atualizarLivro(livro);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
