import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';

class ExportService {
  Future<void> entregarPdf(File arquivo) async {
    if (kIsWeb) {
      await Share.shareXFiles(
        [XFile(arquivo.path)],
        text: 'Relatório de livros',
      );
      return;
    }

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      final resultado = await OpenFile.open(arquivo.path);
      if (resultado.type != ResultType.done) {
        throw Exception(
          'Não foi possível abrir o PDF. ${resultado.message}',
        );
      }
      return;
    }

    await Share.shareXFiles(
      [XFile(arquivo.path)],
      text: 'Relatório de livros',
    );
  }
}
