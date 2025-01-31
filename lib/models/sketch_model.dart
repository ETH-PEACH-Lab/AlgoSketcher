class SketchNode {
  final String id;
  final String label;
  final double x;
  final double y;

  SketchNode(this.id, this.label, this.x, this.y);
}

class SketchEdge {
  final String from;
  final String to;

  SketchEdge(this.from, this.to);
}
