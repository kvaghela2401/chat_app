import 'package:get/get.dart';
import '../models/message.dart';
import '../services/api_service.dart';
import '../services/socket_service.dart';

class ChatController extends GetxController {
  final ApiService _api = ApiService();
  final SocketService socketService = SocketService();
  var messages = <MessageModel>[].obs;

  void initSocket(String baseUrl, String token) {
    socketService.connect(baseUrl, token, (data) {
// assume server sends message as JSON
      try {
        final msg = MessageModel.fromJson(Map<String, dynamic>.from(data));
        messages.add(msg);
      } catch (e) {
        print('invalid message data: $e');
      }
    });
  }

  Future<void> loadMessages(String token, String chatId) async {
    final res = await _api.getMessages(token, chatId);
    messages.value = res.map<MessageModel>((m) => MessageModel.fromJson(m)).toList();
  }

  void sendMessage(String chatId, String senderId, String text) {
    final payload = {
      'chatId': chatId,
      'senderId': senderId,
      'text': text,
      'createdAt': DateTime.now().toIso8601String(),
    };
    socketService.sendMessage('sendMessage', payload);
// local echo
    messages.add(MessageModel.fromJson(payload..['id'] = DateTime.now().millisecondsSinceEpoch.toString()));
  }

  @override
  void onClose() {
    socketService.dispose();
    super.onClose();
  }
}