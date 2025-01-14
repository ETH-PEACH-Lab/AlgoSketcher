import 'package:flutter/material.dart';
import 'screens/drawing_screen.dart';

void main() {
  runApp(DrawingApp());
}

class DrawingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlgoSketcher',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DrawingScreen(),
    );
  }
}
