import 'package:flutter/material.dart';
import 'canvas_switcher.dart';
import 'drawing_canvas.dart';
import 'toolbar.dart';
import 'code_editor.dart';
import '../utils/user_utils.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String activeCanvas = 'Canvas 1';
  final String userId = generateUserId();
  final List<Map<String, String>> users = [
    {'id': 'user_1', 'avatar': 'https://via.placeholder.com/40?text=U1'},
    {'id': 'user_2', 'avatar': 'https://via.placeholder.com/40?text=U2'},
    {'id': 'user_3', 'avatar': 'https://via.placeholder.com/40?text=U3'},
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController codeController = TextEditingController();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50), // 顶部高度
        child: Row(
          children: [
            Expanded(
              child: CanvasSwitcher(
                activeCanvas: activeCanvas,
                onCanvasChanged: (newCanvas) {
                  setState(() {
                    activeCanvas = newCanvas;
                  });
                },
              ),
            ),
            _buildUserAvatarList(), // 用户头像部分
          ],
        ),
      ),
      body: Row(
        children: [
          Toolbar(
            onToolSelected: (tool) {
              // Handle toolbar selection
            },
          ),
          Expanded(
            child: DrawingCanvas(
              canvasId: activeCanvas,
              // userId: userId,
            ),
          ),
          Container(
            width: 300,
            child: CodeEditorScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildUserAvatarList() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      // color: const Color.fromARGB(255, 255, 255, 255),
      child: Row(
        children: users.map((user) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Tooltip(
              message: user['id'], // 鼠标悬停时显示用户 ID
              child: CircleAvatar(
                backgroundImage: NetworkImage(user['avatar']!),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
