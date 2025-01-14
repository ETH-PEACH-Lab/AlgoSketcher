import 'dart:math';
import 'package:flutter/material.dart';

class ShapeRecognizer {
  static String recognizeShape(List<Offset> points) {
    if (points.isEmpty) return 'Unknown';
    
    final center = _calculateCentroid(points);
    final radii = points.map((p) => (p - center).distance).toList();
    final avgRadius = radii.reduce((a, b) => a + b) / radii.length;

    final variance = radii
        .map((r) => pow(r - avgRadius, 2))
        .reduce((a, b) => a + b) /
        radii.length;

    if (variance < 5.0) {
      return 'Circle';
    } else {
      return 'Unknown Shape';
    }
  }

  static Offset _calculateCentroid(List<Offset> points) {
    final sum = points.reduce((a, b) => Offset(a.dx + b.dx, a.dy + b.dy));
    return Offset(sum.dx / points.length, sum.dy / points.length);
  }
}
