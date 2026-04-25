import 'package:app_livros/models/livro.dart';
import 'package:flutter/material.dart';

class ItemLivroLista extends StatelessWidget {
  final Livro livro;
  final VoidCallback? onUpdate;

  const ItemLivroLista({super.key, required this.livro, this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: livro.cor,
          child: const Icon(Icons.menu_book, color: Colors.white),
        ),
        title: Text(
          livro.titulo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Autor: ${livro.autor}\nGênero: ${livro.genero}'),
        isThreeLine: true,
        trailing: Wrap(
          spacing: 2,
          children: [
            IconButton(
              icon: Icon(
                livro.liked ? Icons.favorite : Icons.favorite_border,
                color: const Color.fromARGB(255, 66, 13, 76),
              ),
              onPressed: () {
                livro.liked = !livro.liked;
                if (livro.liked) livro.disliked = false;
                onUpdate?.call();
              },
            ),
            IconButton(
              icon: Icon(
                livro.lido ? Icons.check_circle : Icons.check_circle_outline,
                color: const Color.fromARGB(255, 66, 13, 76),
              ),
              onPressed: () {
                livro.lido = !livro.lido;
                onUpdate?.call();
              },
            ),
            IconButton(
              icon: Icon(
                livro.disliked
                    ? Icons.thumb_down
                    : Icons.thumb_down_alt_outlined,
                color: const Color.fromARGB(255, 66, 13, 76),
              ),
              onPressed: () {
                livro.disliked = !livro.disliked;
                if (livro.disliked) livro.liked = false;
                onUpdate?.call();
              },
            ),
          ],
        ),
      ),
    );
  }
}
