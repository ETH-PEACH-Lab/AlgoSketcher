import 'package:flutter/material.dart';

class SketchVisualizer extends StatelessWidget {
  final List<dynamic> logs;

  SketchVisualizer({required this.logs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sketch Visualizer")),
      body: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (context, index) {
          final log = logs[index];
          return ListTile(
            title: Text("Step ${index + 1}:"),
            subtitle: Text(log.toString()), // 显示每一步的日志
          );
        },
      ),
    );
  }
}
