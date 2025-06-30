import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:web_socket_channel/io.dart';

class WebSocketService {
  final _controller = StreamController<List<Map<String, dynamic>>>.broadcast();
  WebSocket? _socket;
  late IOWebSocketChannel _channel;
  int _reconnectDelay = 2;
  Timer? _reconnectTimer;

  Stream<List<Map<String, dynamic>>> get stream => _controller.stream;

  void connect() {
    try {
      _channel = IOWebSocketChannel.connect('ws://192.168.1.8:8080/ws');
      _reconnectDelay = 2;
      print("✅ Connected to WebSocket");
      _channel.stream.listen(
        _onMessage,
        onDone: _scheduleReconnect,
        onError: (e) => _scheduleReconnect(),
      );
    } catch (_) {
      _scheduleReconnect();
    }
  }

  // void connect() async {
  //   try {
  //     final channel= IOWebSocketChannel.connect('ws://192.168.1.8:8080');
  //     // _socket = await WebSocket.connect('ws://192.168.1.8:8080');
  //     _reconnectDelay = 2;
  //     _socket!.listen(
  //       _onMessage,
  //       onDone: _scheduleReconnect,
  //       onError: (e) => _scheduleReconnect(),
  //     );
  //   } catch (_) {
  //     _scheduleReconnect();
  //   }
  // }

  void _onMessage(dynamic message) {
    try {
      final decoded = jsonDecode(message);
      if (decoded is List) {
        _controller.add(List<Map<String, dynamic>>.from(decoded));
      }
    } catch (_) {
      print("❌ Malformed message discarded.");
    }
  }

  void _scheduleReconnect() {
    if (_reconnectTimer?.isActive ?? false) return;

    print('🔁 Reconnecting in $_reconnectDelay seconds...');
    _reconnectTimer = Timer(Duration(seconds: _reconnectDelay), connect);
    _reconnectDelay = (_reconnectDelay * 2).clamp(2, 30);
  }

  void dispose() {
    _controller.close();
    _socket?.close();
  }
}
