import 'package:app_livros/controller/livro_controller.dart';
import 'package:app_livros/model/tipo_filtro_livro.dart';
import 'package:app_livros/view/theme/cores_app.dart';
import 'package:app_livros/view/widgets/botao_exportar_pdf.dart';
import 'package:app_livros/view/widgets/campo_busca_livros.dart';
import 'package:app_livros/view/widgets/item_livro_lista.dart';
import 'package:app_livros/view/widgets/texto_formatado.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaFavoritos extends StatefulWidget {
  const TelaFavoritos({super.key});

  @override
  State<TelaFavoritos> createState() => _TelaFavoritosState();
}

class _TelaFavoritosState extends State<TelaFavoritos> {
  final _buscaController = TextEditingController();
  static const _tipo = TipoFiltroLivro.favoritos;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final controller = context.read<LivroController>();
      controller.limparBusca();
      _buscaController.clear();
    });
  }

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LivroController>();
    final favoritos = controller.filtrarPorTipo(_tipo);

    final mensagemVazia = !controller.possuiItensNoTipo(_tipo)
        ? 'Nenhum favorito ainda!'
        : 'Nenhum livro encontrado para esta busca.';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        backgroundColor: CoresApp.primaria,
        foregroundColor: Colors.white,
        actions: [BotaoExportarPdf(tipo: _tipo)],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextoFormatado(
              'Livros favoritados!',
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            const TextoFormatado(
              'Livros que você gostou muito e quer ler de novo ou recomendar para alguém!',
              fontStyle: FontStyle.italic,
              fontSize: 14,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            CampoBuscaLivros(controller: _buscaController),
            const SizedBox(height: 16),
            Expanded(
              child: favoritos.isEmpty
                  ? Center(child: Text(mensagemVazia))
                  : ListView.builder(
                      itemCount: favoritos.length,
                      itemBuilder: (context, index) {
                        final livro = favoritos[index];
                        return ItemLivroLista(
                          livro: livro,
                          onUpdate: () async {
                            await controller.atualizarLivro(livro);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
