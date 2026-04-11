import 'package:app_livros/widgets/texto_formatado.dart';
import 'package:flutter/material.dart';

import 'package:app_livros/models/livro.dart';
import 'package:app_livros/widgets/card_livros.dart';

class TelaNaoCurtidos extends StatefulWidget {
  final List<Livro> listaLivros;
  const TelaNaoCurtidos({super.key, required this.listaLivros});

  @override
  State<TelaNaoCurtidos> createState() => _TelaNaoCurtidosState();
}

class _TelaNaoCurtidosState extends State<TelaNaoCurtidos> {
  @override
  Widget build(BuildContext context) {
    final naoCurtidos = widget.listaLivros.where((l) => l.disliked).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Não curtidos'),
        backgroundColor: const Color.fromARGB(255, 66, 13, 76),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                        return CardLivros(
                          livro: naoCurtidos[index],
                          onUpdate: () => setState(() {}),
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
