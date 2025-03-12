import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  const ReusableText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    this.textAlign = TextAlign.left
  });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
      textAlign: textAlign,
    );
  }
}
