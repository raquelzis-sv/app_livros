import 'package:app_livros/models/livro.dart';
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

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  widget.livro.liked ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    widget.livro.liked = !widget.livro.liked;
                    if (widget.livro.liked) widget.livro.disliked = false;
                  });
                  if (widget.onUpdate != null) widget.onUpdate!();
                },
              ),
              IconButton(
                icon: Icon(
                  widget.livro.lido
                      ? Icons.check_circle
                      : Icons.check_circle_outline,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    widget.livro.lido = !widget.livro.lido;
                  });
                  if (widget.onUpdate != null) widget.onUpdate!();
                },
              ),
              IconButton(
                icon: Icon(
                  widget.livro.disliked
                      ? Icons.thumb_down
                      : Icons.thumb_down_alt_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    widget.livro.disliked = !widget.livro.disliked;
                    if (widget.livro.disliked) widget.livro.liked = false;
                  });
                  if (widget.onUpdate != null) widget.onUpdate!();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
