import 'package:app_livros/controller/livro_controller.dart';
import 'package:app_livros/view/widgets/item_livro_lista.dart';
import 'package:app_livros/view/widgets/texto_formatado.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaNaoCurtidos extends StatelessWidget {
  const TelaNaoCurtidos({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LivroController>();
    final naoCurtidos = controller.livrosNaoCurtidos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Não curtidos'),
        backgroundColor: const Color.fromARGB(255, 66, 13, 76),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextoFormatado(
              'Livros que você não gostou',
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            TextoFormatado(
              'Se, der outra chance, é só desmarcar os que você não gostou!',
              fontStyle: FontStyle.italic,
              fontSize: 14,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Expanded(
              child: naoCurtidos.isEmpty
                  ? const Center(child: Text('Nenhum livro não curtido!'))
                  : ListView.builder(
                      itemCount: naoCurtidos.length,
                      itemBuilder: (context, index) {
                        final livro = naoCurtidos[index];
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
