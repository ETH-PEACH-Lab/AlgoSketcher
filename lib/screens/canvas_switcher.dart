import 'package:flutter/material.dart';

class CanvasSwitcher extends StatelessWidget {
  final String activeCanvas;
  final Function(String) onCanvasChanged;

  CanvasSwitcher({required this.activeCanvas, required this.onCanvasChanged});

  @override
  Widget build(BuildContext context) {
    List<String> canvases = ['Canvas 1', 'Canvas 2']; // Example canvases

    return Row(
      children: [
        ...canvases.map((canvas) {
          return GestureDetector(
            onTap: () => onCanvasChanged(canvas),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: activeCanvas == canvas ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                canvas,
                style: TextStyle(
                  color: activeCanvas == canvas ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        }).toList(),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            // Handle new canvas creation
          },
          tooltip: 'New Canvas',
        ),
      ],
    );
  }
}
