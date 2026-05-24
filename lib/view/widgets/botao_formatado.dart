import 'package:app_livros/view/widgets/texto_formatado.dart';
import 'package:flutter/material.dart';

class BotaoFormatado extends StatelessWidget {
  final IconData icone;
  final String legenda;
  final VoidCallback? onTap;

  const BotaoFormatado({
    super.key,
    required this.icone,
    required this.legenda,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 223, 187, 255),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icone,
              color: const Color.fromARGB(255, 76, 28, 117),
              size: 30,
            ),
          ),
        ),
        const SizedBox(height: 6),
        TextoFormatado(
          legenda,
          fontSize: 14,
          color: const Color.fromARGB(255, 76, 28, 117),
        ),
      ],
    );
  }
}
