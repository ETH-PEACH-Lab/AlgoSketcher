import 'package:flutter/material.dart';
import '../models/shape.dart';
import './drawing_painter.dart';
import '../utils/shape_detection.dart';

class DrawingCanvas extends StatefulWidget {
  final String canvasId;

  DrawingCanvas({required this.canvasId});

  @override
  _DrawingCanvasState createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas> {
  List<Offset> currentPoints = []; // 当前绘制的点集合
  List<Shape> detectedShapes = []; // 保存已检测的图形
  Shape? currentShape; // 当前实时检测到的图形

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          currentPoints.add(details.localPosition); // 添加当前点

          // 实时检测形状
          Shape? detectedShape = detectShape(currentPoints);
          if (detectedShape != null) {
            currentShape = detectedShape; // 更新当前形状
          }
        });
      },
      onPanEnd: (details) {
        // 将当前实时检测的图形保存
        if (currentShape != null) {
          setState(() {
            detectedShapes.add(currentShape!);
          });
        }

        currentPoints.clear(); // 清空当前点
        currentShape = null; // 重置当前形状
      },
      child: CustomPaint(
        painter: DrawingPainter(
          shapes: detectedShapes,
          currentPoints: currentPoints,
          currentShape: currentShape,
        ),
        size: Size.infinite,
      ),
    );
  }
}
