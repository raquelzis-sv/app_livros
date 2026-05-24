import 'package:app_livros/model/livro.dart';
import 'package:app_livros/view/widgets/icones_cards.dart';
import 'package:app_livros/view/widgets/texto_formatado.dart';
import 'package:flutter/material.dart';

class CardLivros extends StatefulWidget {
  final Livro livro;
  final VoidCallback? onUpdate;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const CardLivros({
    super.key,
    required this.livro,
    this.onUpdate,
    this.onDelete,
    this.onEdit,
  });

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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 40),

              Expanded(
                child: TextoFormatado(
                  widget.livro.titulo,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                ),
              ),

              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onSelected: (value) {
                  if (value == 'editar') {
                    widget.onEdit?.call();
                  } else if (value == 'excluir') {
                    widget.onDelete?.call();
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'editar', child: Text('Editar')),
                  PopupMenuItem(value: 'excluir', child: Text('Excluir')),
                ],
              ),
            ],
          ),

          const SizedBox(height: 15),

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
