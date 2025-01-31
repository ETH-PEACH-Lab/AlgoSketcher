import 'package:flutter/material.dart';
import '../utils/api_service.dart';
import 'sketch_visualizer.dart';

class CodeEditorScreen extends StatefulWidget {
  @override
  _CodeEditorScreenState createState() => _CodeEditorScreenState();
}

class _CodeEditorScreenState extends State<CodeEditorScreen> {
  final TextEditingController codeController = TextEditingController();
  final List<int> defaultValues = [1, 2, 2, 1];
  bool isLoading = false;

  Future<void> executeCode() async {
    if (codeController.text.trim().isEmpty) {
      _showErrorDialog("Code cannot be empty!");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final result = await ApiService.executeCode(codeController.text, defaultValues);

      // 提取 logs 并传递给 SketchVisualizer
      final logs = result['logs'] as List<dynamic>;

      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SketchVisualizer(logs: logs),
      ));
    } catch (e) {
      _showErrorDialog(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("OK"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Code Editor")),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: codeController,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your code here...',
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: executeCode,
                    child: Text("Run"),
                  ),
          ),
        ],
      ),
    );
  }
}
