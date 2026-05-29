import 'package:flutter/material.dart';

class Livro {
  final int? id;
  final String titulo;
  final String autor;
  final String genero;
  final Color cor;
  bool lido;
  bool liked;
  bool disliked;

  Livro({
    this.id,
    required this.titulo,
    required this.autor,
    required this.genero,
    required this.cor,
    this.lido = false,
    this.liked = false,
    this.disliked = false,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'titulo': titulo,
      'autor': autor,
      'genero': genero,
      'cor': cor.toARGB32(),
      'lido': lido,
      'liked': liked,
      'disliked': disliked,
    };
  }

  factory Livro.fromMap(Map<String, dynamic> map) {
    return Livro(
      id: map['id'],
      titulo: map['titulo'],
      autor: map['autor'],
      genero: map['genero'],
      cor: Color(map['cor']),
      lido: map['lido'] is bool ? map['lido'] : map['lido'] == 1,
      liked: map['liked'] is bool ? map['liked'] : map['liked'] == 1,
      disliked: map['disliked'] is bool
          ? map['disliked']
          : map['disliked'] == 1,
    );
  }
}
