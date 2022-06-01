import 'package:flutter/material.dart';

class Txt extends StatelessWidget {
  const Txt({Key? key, required this.text, this.style})
      : super(key: key);

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}
