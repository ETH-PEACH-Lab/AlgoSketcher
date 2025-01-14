class DSLGenerator {
  static String generate(String shape, Map<String, dynamic> params) {
    switch (shape) {
      case 'Circle':
        return '''
        circle {
          center: (${params['centerX']}, ${params['centerY']});
          radius: ${params['radius']};
          color: ${params['color'] ?? 'black'};
        }
        ''';
      default:
        return '// Unsupported shape';
    }
  }
}
