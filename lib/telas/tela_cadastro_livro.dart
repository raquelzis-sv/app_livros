import 'dart:math';

import 'package:app_livros/models/livro.dart';
import 'package:flutter/material.dart';

class TelaCadastroLivro extends StatefulWidget {
  const TelaCadastroLivro({super.key});

  @override
  State<TelaCadastroLivro> createState() => _TelaCadastroLivroState();
}

class _TelaCadastroLivroState extends State<TelaCadastroLivro> {
  final _tituloController = TextEditingController();
  final _autorController = TextEditingController();
  final _generoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Livro'),
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
              child: const Text("Salvar"),
              onPressed: () {
                if (_tituloController.text.trim().isEmpty ||
                    _autorController.text.trim().isEmpty ||
                    _generoController.text.trim().isEmpty) {
                  Navigator.pop(context, null);
                } else {
                  final novoLivro = Livro(
                    id: DateTime.now().toString(),
                    titulo: _tituloController.text,
                    autor: _autorController.text,
                    genero: _generoController.text,
                    cor: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                  );
                  Navigator.pop(context, novoLivro);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
