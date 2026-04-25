import 'dart:math';

import 'package:app_livros/models/livro.dart';
import 'package:app_livros/widgets/texto_formatado.dart';
import 'package:flutter/material.dart';

class TelaCadastroLivro extends StatefulWidget {
  final Livro? livro;

  const TelaCadastroLivro({super.key, this.livro});

  @override
  State<TelaCadastroLivro> createState() => _TelaCadastroLivroState();
}

class _TelaCadastroLivroState extends State<TelaCadastroLivro> {
  final _tituloController = TextEditingController();
  final _autorController = TextEditingController();
  final _generoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.livro != null) {
      _tituloController.text = widget.livro!.titulo;
      _autorController.text = widget.livro!.autor;
      _generoController.text = widget.livro!.genero;
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _autorController.dispose();
    _generoController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_tituloController.text.trim().isEmpty ||
        _autorController.text.trim().isEmpty ||
        _generoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos.')),
      );
      return;
    }

    final livroSalvo = Livro(
      id: widget.livro?.id,
      titulo: _tituloController.text.trim(),
      autor: _autorController.text.trim(),
      genero: _generoController.text.trim(),
      cor:
          widget.livro?.cor ??
          Colors.primaries[Random().nextInt(Colors.primaries.length)],
      lido: widget.livro?.lido ?? false,
      liked: widget.livro?.liked ?? false,
      disliked: widget.livro?.disliked ?? false,
    );

    Navigator.pop(context, livroSalvo);
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.livro != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Editar Livro' : 'Cadastrar Livro'),
        backgroundColor: const Color.fromARGB(255, 66, 13, 76),
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: _autorController,
              decoration: const InputDecoration(
                labelText: 'Autor',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: _generoController,
              decoration: const InputDecoration(
                labelText: 'Gênero',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _salvar,
              child: TextoFormatado(
                isEditMode ? 'Salvar alterações' : 'Salvar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
