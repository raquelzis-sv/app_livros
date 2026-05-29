import 'package:app_livros/model/livro.dart';
import 'package:app_livros/model/tipo_filtro_livro.dart';
import 'package:app_livros/service/export_service.dart';
import 'package:app_livros/service/livro_service.dart';
import 'package:app_livros/service/pdf_service.dart';
import 'package:flutter/material.dart';

class LivroController extends ChangeNotifier {
  final LivroService _service;
  final PdfService _pdfService;
  final ExportService _exportService;

  List<Livro> listaLivros = [];
  bool carregando = false;
  bool exportandoPdf = false;
  String textoBusca = '';

  LivroController(
    this._service, [
    PdfService? pdfService,
    ExportService? exportService,
  ])  : _pdfService = pdfService ?? PdfService(),
        _exportService = exportService ?? ExportService();

  bool get temBuscaAtiva => textoBusca.trim().isNotEmpty;

  List<Livro> get livrosLidos =>
      listaLivros.where((livro) => livro.lido).toList();

  List<Livro> get livrosFavoritos =>
      listaLivros.where((livro) => livro.liked).toList();

  List<Livro> get livrosNaoCurtidos =>
      listaLivros.where((livro) => livro.disliked).toList();

  List<Livro> filtrarPorTipo(TipoFiltroLivro tipo) {
    final base = switch (tipo) {
      TipoFiltroLivro.lidos => livrosLidos,
      TipoFiltroLivro.favoritos => livrosFavoritos,
      TipoFiltroLivro.naoCurtidos => livrosNaoCurtidos,
    };
    return _aplicarBuscaTexto(base);
  }

  bool possuiItensNoTipo(TipoFiltroLivro tipo) {
    return switch (tipo) {
      TipoFiltroLivro.lidos => livrosLidos.isNotEmpty,
      TipoFiltroLivro.favoritos => livrosFavoritos.isNotEmpty,
      TipoFiltroLivro.naoCurtidos => livrosNaoCurtidos.isNotEmpty,
    };
  }

  void atualizarBusca(String valor) {
    textoBusca = valor;
    notifyListeners();
  }

  void limparBusca() {
    textoBusca = '';
    notifyListeners();
  }

  Future<String?> exportarPdf(TipoFiltroLivro tipo) async {
    final livros = filtrarPorTipo(tipo);
    if (livros.isEmpty) {
      return 'Não há livros para exportar com o filtro atual.';
    }

    exportandoPdf = true;
    notifyListeners();

    try {
      var titulo = tipo.tituloRelatorio;
      if (temBuscaAtiva) {
        titulo = '$titulo — busca: "${textoBusca.trim()}"';
      }

      final arquivo = await _pdfService.gerarRelatorio(
        livros: livros,
        tituloRelatorio: titulo,
      );
      await _exportService.entregarPdf(arquivo);
      return null;
    } catch (e) {
      return 'Não foi possível gerar ou abrir o PDF.';
    } finally {
      exportandoPdf = false;
      notifyListeners();
    }
  }

  List<Livro> _aplicarBuscaTexto(List<Livro> livros) {
    final termo = textoBusca.trim().toLowerCase();
    if (termo.isEmpty) return livros;

    return livros
        .where(
          (livro) =>
              livro.titulo.toLowerCase().contains(termo) ||
              livro.autor.toLowerCase().contains(termo) ||
              livro.genero.toLowerCase().contains(termo),
        )
        .toList();
  }

  Future<void> carregarLivros() async {
    carregando = true;
    notifyListeners();

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

  void limpar() {
    listaLivros = [];
    carregando = false;
    exportandoPdf = false;
    textoBusca = '';
    notifyListeners();
  }
}
