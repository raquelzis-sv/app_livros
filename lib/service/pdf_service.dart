import 'dart:io';

import 'package:app_livros/model/livro.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  Future<File> gerarRelatorio({
    required List<Livro> livros,
    required String tituloRelatorio,
  }) async {
    final doc = pw.Document();
    final agora = DateTime.now();
    final dataFormatada =
        '${agora.day.toString().padLeft(2, '0')}/'
        '${agora.month.toString().padLeft(2, '0')}/'
        '${agora.year} '
        '${agora.hour.toString().padLeft(2, '0')}:'
        '${agora.minute.toString().padLeft(2, '0')}';

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          pw.Text(
            'Minha Biblioteca',
            style: pw.TextStyle(
              fontSize: 22,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            tituloRelatorio,
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 4),
          pw.Text('Gerado em: $dataFormatada'),
          pw.Text('Total de registros: ${livros.length}'),
          pw.SizedBox(height: 20),
          pw.TableHelper.fromTextArray(
            headers: const [
              'Título',
              'Autor',
              'Gênero',
              'Lido',
              'Favorito',
              'Não curtiu',
            ],
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
            cellAlignment: pw.Alignment.centerLeft,
            data: livros
                .map(
                  (livro) => [
                    livro.titulo,
                    livro.autor,
                    livro.genero,
                    _simNao(livro.lido),
                    _simNao(livro.liked),
                    _simNao(livro.disliked),
                  ],
                )
                .toList(),
          ),
        ],
      ),
    );

    final bytes = await doc.save();
    final diretorio = await getTemporaryDirectory();
    final arquivo = File(
      '${diretorio.path}/relatorio_livros_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
    await arquivo.writeAsBytes(bytes);
    return arquivo;
  }

  String _simNao(bool valor) => valor ? 'Sim' : 'Não';
}
