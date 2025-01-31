import 'package:flutter/material.dart';

class CursorModel {
  final Offset position; // 鼠标指针的位置
  final Color color; // 鼠标指针的颜色

  CursorModel({
    required this.position,
    required this.color,
  });
}
