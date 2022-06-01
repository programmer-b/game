// ignore_for_file: empty_constructor_bodies

import 'package:flutter/material.dart';
import 'package:game/Widgets/txt.dart';

import '../Constants/dimens.dart';

class GameValue extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const GameValue({this.width = 100, this.name, this.value, this.fontSize = 24});
  final double width;
  final String? name;
  final String? value;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: width,
            child: Txt(text: name!, style: TextStyle(fontSize: fontSize))),
        const SizedBox(width: Dimens.defaultPadding),
        Txt(text: ':', style: TextStyle(fontSize: fontSize)),
        const SizedBox(width: Dimens.defaultPadding),
        Txt(text: value!, style: TextStyle(fontSize: fontSize))
      ],
    );
  }
}
