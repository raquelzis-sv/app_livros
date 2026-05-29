import 'package:app_livros/controller/livro_controller.dart';
import 'package:app_livros/model/tipo_filtro_livro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BotaoExportarPdf extends StatelessWidget {
  final TipoFiltroLivro tipo;

  const BotaoExportarPdf({super.key, required this.tipo});

  Future<void> _exportar(BuildContext context) async {
    final controller = context.read<LivroController>();
    final mensagem = await controller.exportarPdf(tipo);

    if (!context.mounted || mensagem == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final exportando = context.watch<LivroController>().exportandoPdf;

    return IconButton(
      icon: exportando
          ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : const Icon(Icons.picture_as_pdf),
      tooltip: 'Exportar PDF',
      onPressed: exportando ? null : () => _exportar(context),
    );
  }
}
