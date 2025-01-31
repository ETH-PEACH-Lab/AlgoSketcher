import 'package:flutter/material.dart';

class Shape {
  final String type; // 图形类型（如矩形、圆形等）
  final List<Offset> points; // 图形的点集合
  final String label; // 标签名称

  Shape({
    required this.type,
    required this.points,
    required this.label,
  });
}
