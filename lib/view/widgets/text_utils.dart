import 'package:flutter/material.dart';

class TextUtils extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextDecoration underLine;
  late List<Shadow> shadow=[];

  TextUtils({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    required this.underLine,
    shadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          decoration: underLine,
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          shadows: shadow,
        ));
  }
}
