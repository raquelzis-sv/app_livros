import 'package:app_livros/controller/livro_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CampoBuscaLivros extends StatelessWidget {
  final TextEditingController controller;

  const CampoBuscaLivros({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final livroController = context.watch<LivroController>();

    return TextField(
      controller: controller,
      onChanged: livroController.atualizarBusca,
      decoration: InputDecoration(
        hintText: 'Buscar por título, autor ou gênero...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: livroController.temBuscaAtiva
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                  livroController.limparBusca();
                },
              )
            : null,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
    );
  }
}
