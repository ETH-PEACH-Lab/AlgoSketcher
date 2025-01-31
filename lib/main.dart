import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(AlgoSketcherApp());
}

class AlgoSketcherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlgoSketcher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}
