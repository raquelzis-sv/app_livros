import 'package:app_livros/models/livro.dart';
import 'package:app_livros/widgets/icones_cards.dart';
import 'package:app_livros/widgets/texto_formatado.dart';
import 'package:flutter/material.dart';

class CardLivros extends StatefulWidget {
  final Livro livro;
  final VoidCallback? onUpdate;

  const CardLivros({super.key, required this.livro, this.onUpdate});

  @override
  State<CardLivros> createState() => _CardLivrosState();
}

class _CardLivrosState extends State<CardLivros> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: widget.livro.cor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 1),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          TextoFormatado(
            widget.livro.titulo,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 10),

          TextoFormatado(
            'Autor: ${widget.livro.autor}',
            fontSize: 16,
            color: Colors.white,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 5),

          TextoFormatado(
            'Gênero: ${widget.livro.genero}',
            fontSize: 16,
            color: Colors.white,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          IconesCards(livro: widget.livro, onUpdate: widget.onUpdate),
        ],
      ),
    );
  }
}
