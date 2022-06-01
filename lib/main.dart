import 'package:flutter/material.dart';

import 'game_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baseball game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GameRoute(title: 'Baseball game'),
    );
  }
}
