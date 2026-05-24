import 'package:flutter/material.dart';
import 'package:app_livros/model/livro.dart';
import 'package:app_livros/service/livro_service.dart';

class LivroController extends ChangeNotifier {
  final LivroService _service;

  List<Livro> listaLivros = [];
  bool carregando = false;

  LivroController(this._service);

  Future<void> carregarLivros() async {
    carregando = true;
    notifyListeners(); // Avisa a tela para mostrar um loading

    listaLivros = await _service.getLivros();

    carregando = false;
    notifyListeners();
  }

  Future<void> adicionarLivro(Livro livro) async {
    await _service.salvarLivro(livro);
    await carregarLivros();
  }

  Future<void> atualizarLivro(Livro livro) async {
    await _service.atualizarLivro(livro);
    await carregarLivros();
  }

  Future<void> deletarLivro(int id) async {
    await _service.deletarLivro(id);
    await carregarLivros();
  }
}
