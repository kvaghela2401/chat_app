import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket? socket;

  void connect(String baseUrl, String token, Function(dynamic) onMessage) {
    socket = IO.io(baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'extraHeaders': {'Authorization': 'Bearer $token'}
    });

    socket!.connect();

    socket!.onConnect((_) {
      print('connected to socket server');
    });

    socket!.on('message', (data) {
      onMessage(data);
    });

    socket!.onDisconnect((_) => print('socket disconnected'));
  }

  void sendMessage(String event, Map<String, dynamic> payload) {
    socket?.emit(event, payload);
  }

  void dispose() {
    socket?.dispose();
    socket = null;
  }
}