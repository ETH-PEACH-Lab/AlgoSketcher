import '../models/sketch_model.dart';

class SketchBuilder {
  static List<SketchNode> buildNodes(Map<String, dynamic> state) {
    List<SketchNode> nodes = [];
    double x = 0.0;
    double y = 0.0;

    state.forEach((key, value) {
      nodes.add(SketchNode(key, value.toString(), x, y));
      x += 100.0; // 调整节点间距
    });

    return nodes;
  }

  static List<SketchEdge> buildEdges(List<SketchNode> nodes) {
    List<SketchEdge> edges = [];

    for (int i = 0; i < nodes.length - 1; i++) {
      edges.add(SketchEdge(nodes[i].id, nodes[i + 1].id));
    }

    return edges;
  }
}
