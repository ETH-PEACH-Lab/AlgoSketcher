import 'package:flutter/material.dart';

List<Offset> simplifyPoints(List<Offset> points, double epsilon) {
  if (points.length < 3) return points;

  int index = 0;
  double maxDistance = 0;

  for (int i = 1; i < points.length - 1; i++) {
    double distance = perpendicularDistance(points[i], points.first, points.last);
    if (distance > maxDistance) {
      index = i;
      maxDistance = distance;
    }
  }

  if (maxDistance > epsilon) {
    List<Offset> left = simplifyPoints(points.sublist(0, index + 1), epsilon);
    List<Offset> right = simplifyPoints(points.sublist(index), epsilon);

    return [...left, ...right.skip(1)];
  } else {
    // 如果所有点都在误差范围内，仅保留起点和终点
    return [points.first, points.last];
  }
}


double perpendicularDistance(Offset point, Offset lineStart, Offset lineEnd) {
  double dx = lineEnd.dx - lineStart.dx;
  double dy = lineEnd.dy - lineStart.dy;

  double magnitude = dx * dx + dy * dy;
  if (magnitude == 0) return (point - lineStart).distance;

  double u = ((point.dx - lineStart.dx) * dx + (point.dy - lineStart.dy) * dy) / magnitude;

  Offset intersection = Offset(
    lineStart.dx + u * dx,
    lineStart.dy + u * dy,
  );

  return (point - intersection).distance;
}

Offset getCenter(List<Offset> points) {
  if (points.isEmpty) return Offset.zero;

  double sumX = points.map((p) => p.dx).reduce((a, b) => a + b);
  double sumY = points.map((p) => p.dy).reduce((a, b) => a + b);

  return Offset(sumX / points.length, sumY / points.length);
}
