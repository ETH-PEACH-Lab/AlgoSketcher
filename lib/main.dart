import 'package:flutter/material.dart';
import 'screens/drawing_screen.dart';
import 'screens/result_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlgoSketcher',
      theme: ThemeData(primarySwatch: Colors.blue),
      // 注册路由
      initialRoute: '/',
      routes: {
        '/': (context) => DrawingScreen(),
        '/result': (context) => ResultScreen(),
      },
    );
  }
}
