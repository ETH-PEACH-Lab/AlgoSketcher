import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  late WebSocketChannel channel;

  factory WebSocketService() => _instance;

  WebSocketService._internal();

  void connect(String url) {
    channel = WebSocketChannel.connect(Uri.parse(url));
  }

  void send(String message) {
    channel.sink.add(message);
  }

  Stream<dynamic> get stream => channel.stream;

  void disconnect() {
    channel.sink.close();
  }
}
