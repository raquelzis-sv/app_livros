import 'package:app_livros/models/livro.dart';
import 'package:flutter/material.dart';

class IconesCards extends StatefulWidget {
  final Livro livro;
  final VoidCallback? onUpdate;

  const IconesCards({super.key, required this.livro, this.onUpdate});

  @override
  State<IconesCards> createState() => _IconesCardsState();
}

class _IconesCardsState extends State<IconesCards> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
            widget.livro.lido ? Icons.check_circle : Icons.check_circle_outline,
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
    );
  }
}
