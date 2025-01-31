import 'package:flutter/material.dart';
import '../models/shape.dart';
import 'geometry_utils.dart';
import 'dart:math';

enum ShapeType { Circle, Rectangle, Line }

bool isShapeCloseEnough(
    List<Offset> points, ShapeType shapeType, {double tolerance = 20.0}) {
  if (points.isEmpty) return false;

  switch (shapeType) {
    case ShapeType.Circle:
      return isCircle(points, tolerance: tolerance);
    case ShapeType.Rectangle:
      return isRectangle(points, angleTolerance: tolerance);
    case ShapeType.Line:
      return isLine(points, tolerance: tolerance);
    default:
      return false;
  }
}

Shape? detectShape(List<Offset> points) {
  if (points.isEmpty) return null;

  List<Offset> simplified = simplifyPoints(points, 10.0);

  // 模糊匹配图形类型
  if (isShapeCloseEnough(simplified, ShapeType.Circle, tolerance: 20.0)) {
    return Shape(type: 'Circle', points: simplified, label: 'Circle');
  }
  if (isShapeCloseEnough(simplified, ShapeType.Rectangle, tolerance: 30.0)) {
    return Shape(type: 'Rectangle', points: simplified, label: 'Rectangle');
  }
  if (isShapeCloseEnough(simplified, ShapeType.Line, tolerance: 10.0)) {
    return Shape(type: 'Arrow', points: simplified, label: 'Arrow');
  }

  // 无法匹配时标记为不规则图形
  return Shape(type: 'Irregular', points: simplified, label: 'Irregular');
}

// 圆形检测
bool isCircle(List<Offset> points, {double tolerance = 20.0}) {
  if (points.length < 5) return false; // 降低点数量的最低要求

  Offset center = getCenter(points);
  double averageRadius = points
      .map((p) => (p - center).distance)
      .reduce((a, b) => a + b) / points.length;

  for (var point in points) {
    if (((point - center).distance - averageRadius).abs() > tolerance) {
      return false;
    }
  }
  return true;
}


// 矩形检测
bool isRectangle(List<Offset> points, {double angleTolerance = 30.0}) {
  if (points.length < 4) return false; // 降低对点数量的要求

  List<Offset> simplified = simplifyPoints(points, 10.0);
  if (simplified.length != 4) return false; // 需要简化为 4 个顶点

  for (int i = 0; i < 4; i++) {
    Offset p1 = simplified[i];
    Offset p2 = simplified[(i + 1) % 4];
    Offset p3 = simplified[(i + 2) % 4];

    double angle = _calculateAngle(p1, p2, p3);
    if ((angle - 90).abs() > angleTolerance) {
      return false;
    }
  }
  return true;
}

// 直线检测
bool isLine(List<Offset> points, {double tolerance = 5.0}) {
  if (points.length < 2) return false;

  Offset start = points.first;
  Offset end = points.last;

  for (var point in points) {
    double distance = perpendicularDistance(point, start, end);
    if (distance > tolerance) {
      return false;
    }
  }
  return true;
}


// 计算点之间的夹角
double _calculateAngle(Offset p1, Offset p2, Offset p3) {
  double dx1 = p2.dx - p1.dx;
  double dy1 = p2.dy - p1.dy;
  double dx2 = p3.dx - p2.dx;
  double dy2 = p3.dy - p2.dy;

  double dotProduct = dx1 * dx2 + dy1 * dy2;
  double magnitude1 = sqrt(dx1 * dx1 + dy1 * dy1);
  double magnitude2 = sqrt(dx2 * dx2 + dy2 * dy2);

  double angle = acos(dotProduct / (magnitude1 * magnitude2)) * 180 / pi;
  return angle;
}