import 'dart:math';
import 'package:flutter/material.dart';
import '../models/shape.dart';

class DrawingPainter extends CustomPainter {
  final List<Shape> shapes; // 已检测的图形
  final List<Offset> currentPoints; // 当前正在绘制的点
  final Shape? currentShape; // 当前实时检测到的图形

  DrawingPainter({
    required this.shapes,
    required this.currentPoints,
    required this.currentShape,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // 绘制当前正在绘制的点
    paint.color = Colors.black;
    for (int i = 0; i < currentPoints.length - 1; i++) {
      canvas.drawLine(currentPoints[i], currentPoints[i + 1], paint);
    }

    // 绘制实时检测到的图形
    if (currentShape != null) {
      _drawShape(canvas, paint, currentShape!);
    }

    // 绘制已检测到的图形
    for (var shape in shapes) {
      _drawShape(canvas, paint, shape);
    }
  }

  void _drawShape(Canvas canvas, Paint paint, Shape shape) {
    if (shape.type == 'Rectangle') {
      paint.color = Colors.blue;
      Rect rect = _getBoundingRect(shape.points);
      canvas.drawRect(rect, paint);
    } else if (shape.type == 'Circle') {
      paint.color = Colors.green;
      Offset center = _getCenter(shape.points);
      double radius = _getRadius(center, shape.points);
      canvas.drawCircle(center, radius, paint);
    } else if (shape.type == 'Arrow') {
      paint.color = Colors.red;

      // 绘制箭头主体（直线）
      Offset start = shape.points.first;
      Offset end = shape.points.last;
      canvas.drawLine(start, end, paint);

      // 绘制箭头头部
      _drawArrowHead(canvas, paint, start, end);
    } else if (shape.type == 'Irregular') {
      paint.color = Colors.orange;

      // 绘制不规则图形
      Path path = Path();
      path.moveTo(shape.points.first.dx, shape.points.first.dy);
      for (var point in shape.points.skip(1)) {
        path.lineTo(point.dx, point.dy);
      }
      canvas.drawPath(path, paint);
    }

    // 绘制标签
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: shape.label,
        style: TextStyle(color: Colors.red, fontSize: 14),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    Offset labelPosition = _getLabelPosition(shape.points);
    textPainter.paint(canvas, labelPosition);
  }

  Rect _getBoundingRect(List<Offset> points) {
    double minX = points.map((p) => p.dx).reduce((a, b) => a < b ? a : b);
    double minY = points.map((p) => p.dy).reduce((a, b) => a < b ? a : b);
    double maxX = points.map((p) => p.dx).reduce((a, b) => a > b ? a : b);
    double maxY = points.map((p) => p.dy).reduce((a, b) => a > b ? a : b);

    return Rect.fromLTRB(minX, minY, maxX, maxY);
  }

  Offset _getCenter(List<Offset> points) {
    double avgX = points.map((p) => p.dx).reduce((a, b) => a + b) / points.length;
    double avgY = points.map((p) => p.dy).reduce((a, b) => a + b) / points.length;
    return Offset(avgX, avgY);
  }

  double _getRadius(Offset center, List<Offset> points) {
    return points.map((p) => (p - center).distance).reduce((a, b) => a + b) / points.length;
  }

  Offset _getLabelPosition(List<Offset> points) {
    Offset center = _getCenter(points);
    return Offset(center.dx - 20, center.dy - 10); // 标签位置偏移
  }

  void _drawArrowHead(Canvas canvas, Paint paint, Offset start, Offset end) {
    const double arrowHeadLength = 10.0;
    const double arrowAngle = 30.0;

    // 计算箭头方向
    double dx = end.dx - start.dx;
    double dy = end.dy - start.dy;
    double angle = atan2(dy, dx);

    // 左侧箭头线
    double angle1 = angle + arrowAngle * pi / 180;
    Offset arrowLeft = Offset(
      end.dx - arrowHeadLength * cos(angle1),
      end.dy - arrowHeadLength * sin(angle1),
    );

    // 右侧箭头线
    double angle2 = angle - arrowAngle * pi / 180;
    Offset arrowRight = Offset(
      end.dx - arrowHeadLength * cos(angle2),
      end.dy - arrowHeadLength * sin(angle2),
    );

    // 绘制箭头线段
    canvas.drawLine(end, arrowLeft, paint);
    canvas.drawLine(end, arrowRight, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
