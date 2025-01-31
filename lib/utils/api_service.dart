import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:5000'; // 后端服务地址

  static Future<Map<String, dynamic>> executeCode(String code, List<int> values) async {
    final response = await http.post(
      Uri.parse('$baseUrl/execute'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"code": code, "values": values}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to execute code: ${response.body}");
    }
  }
}
