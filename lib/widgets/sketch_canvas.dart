import 'package:flutter/material.dart';

class SketchCanvas extends StatelessWidget {
  final Map<String, dynamic> state;

  SketchCanvas(this.state);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, 100),
      painter: SketchPainter(state: state),
    );
  }
}

class SketchPainter extends CustomPainter {
  final Map<String, dynamic> state;

  SketchPainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    final double nodeWidth = 50.0;
    final double nodeHeight = 30.0;
    final double spacing = 20.0;

    double x = spacing;
    double y = size.height / 2 - nodeHeight / 2;

    state.forEach((key, value) {
      canvas.drawRect(
        Rect.fromLTWH(x, y, nodeWidth, nodeHeight),
        paint..color = Colors.grey[300]!,
      );
      final textPainter = TextPainter(
        text: TextSpan(
          text: key,
          style: TextStyle(color: Colors.black),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x + 5, y + 5));

      x += nodeWidth + spacing;
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
