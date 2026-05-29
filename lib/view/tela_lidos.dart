import 'package:app_livros/controller/livro_controller.dart';
import 'package:app_livros/model/tipo_filtro_livro.dart';
import 'package:app_livros/view/theme/cores_app.dart';
import 'package:app_livros/view/widgets/botao_exportar_pdf.dart';
import 'package:app_livros/view/widgets/campo_busca_livros.dart';
import 'package:app_livros/view/widgets/item_livro_lista.dart';
import 'package:app_livros/view/widgets/texto_formatado.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaLidos extends StatefulWidget {
  const TelaLidos({super.key});

  @override
  State<TelaLidos> createState() => _TelaLidosState();
}

class _TelaLidosState extends State<TelaLidos> {
  final _buscaController = TextEditingController();
  static const _tipo = TipoFiltroLivro.lidos;

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
    final lidos = controller.filtrarPorTipo(_tipo);

    final mensagemVazia = !controller.possuiItensNoTipo(_tipo)
        ? 'Nenhum livro lido ainda!'
        : 'Nenhum livro encontrado para esta busca.';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Livros lidos'),
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
              'Livros que você já leu!',
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            const TextoFormatado(
              'Aqui ficam os livros que você já leu, ficam guardados para você se lembrar e também poder avaliar se gostou ou não.',
              fontStyle: FontStyle.italic,
              fontSize: 14,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            CampoBuscaLivros(controller: _buscaController),
            const SizedBox(height: 16),
            Expanded(
              child: lidos.isEmpty
                  ? Center(child: Text(mensagemVazia))
                  : ListView.builder(
                      itemCount: lidos.length,
                      itemBuilder: (context, index) {
                        final livro = lidos[index];
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
