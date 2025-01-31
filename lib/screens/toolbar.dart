import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // 引入 SVG 支持包

class Toolbar extends StatelessWidget {
  final Function(String) onToolSelected;

  Toolbar({required this.onToolSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // 宽度调整以适应图标和文字
      color: Colors.grey[200],
      child: Column(
        children: [
          // 工具标题
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Toolbar',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          // 自由绘制按钮
          IconButton(
            icon: Icon(Icons.brush),
            onPressed: () => onToolSelected('freestyle'),
            tooltip: 'Freestyle Pen',
          ),

          // 示例分割线
          Divider(),

          // 示例图标标题
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Examples',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          // 示例图示：Array
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Text(
                  'Array',
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                SvgPicture.asset(
                  'assets/icons/array.svg',
                  width: 40,
                  height: 40,
                ),
              ],
            ),
          ),

          // 示例图示：Linked List
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Text(
                  'Linked List',
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                SvgPicture.asset(
                  'assets/icons/linked_list.svg',
                  width: 40,
                  height: 40,
                ),
              ],
            ),
          ),

          // 示例图示：Matrix
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Text(
                  'Matrix',
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                SvgPicture.asset(
                  'assets/icons/matrix.svg',
                  width: 40,
                  height: 40,
                ),
              ],
            ),
          ),

          // 示例图示：Stack
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Text(
                  'Stack',
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                SvgPicture.asset(
                  'assets/icons/stack.svg',
                  width: 40,
                  height: 40,
                ),
              ],
            ),
          ),

          // 示例图示：Tree
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Text(
                  'Tree',
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                SvgPicture.asset(
                  'assets/icons/tree.svg',
                  width: 40,
                  height: 40,
                ),
              ],
            ),
          ),

          // 示例图示：Graph
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Text(
                  'Graph',
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                SvgPicture.asset(
                  'assets/icons/graph.svg',
                  width: 40,
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
