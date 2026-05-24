import 'package:flutter/material.dart';

class TextoFormatado extends StatelessWidget {
  final String texto;
  final double padding;
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final Color? backgroundColor;
  final Color color;
  final TextAlign textAlign;

  const TextoFormatado(
    this.texto, {
    super.key,
    this.padding = 0.0,
    this.fontSize = 20.0,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.backgroundColor = Colors.transparent,
    this.color = Colors.black,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Text(
        texto,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          backgroundColor: backgroundColor,
          color: color,
        ),
      ),
    );
  }
}
