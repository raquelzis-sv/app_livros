import 'package:app_livros/models/livro.dart';
import 'package:flutter/material.dart';

class CardLivros extends StatefulWidget {
  final Livro livro;

  const CardLivros({super.key, required this.livro});

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
          Text(
            widget.livro.titulo,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            'Autor: ${widget.livro.autor}',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),

          const SizedBox(height: 5),

          Text(
            'Gênero: ${widget.livro.genero}',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
