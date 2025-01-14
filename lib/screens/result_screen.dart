import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 获取传递的 points 参数
    final List<Offset> points = ModalRoute.of(context)!.settings.arguments as List<Offset>;

    // 示例：简单判断是否为闭合图形
    String shape = recognizeShape(points);

    return Scaffold(
      appBar: AppBar(title: Text('Recognition Result')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Detected Shape: $shape', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text('Total Points: ${points.length}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  // 示例识别逻辑
  String recognizeShape(List<Offset> points) {
    if (points.isEmpty) return 'No Shape Detected';
    if ((points.first - points.last).distance < 10.0) {
      return 'Circle (Closed Shape)';
    }
    return 'Unknown Shape';
  }
}
