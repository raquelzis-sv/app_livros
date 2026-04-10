import 'package:flutter/services.dart';

class Livro {
  final String id;
  final String titulo;
  final String autor;
  final String genero;
  final Color cor;
  bool lido;
  bool liked;
  bool disliked;

  Livro({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.genero,
    required this.cor,
    this.lido = false,
    this.liked = false,
    this.disliked = false,
  });
}
