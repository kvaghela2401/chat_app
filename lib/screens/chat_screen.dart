import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';
import '../controllers/auth_controller.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController chatC = Get.put(ChatController());
  final AuthController authC = Get.find();
  final TextEditingController txtC = TextEditingController();
  late String chatId;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments ?? {};
    chatId = args['chatId'] ?? '1';
// TODO: set your socket base url
    chatC.initSocket('https://your-socket-server.com', authC.token.value);
    chatC.loadMessages(authC.token.value, chatId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Get.arguments['name'] ?? 'Chat')),
      body: Column(
        children: [
          Expanded(child: Obx(() {
            return ListView.builder(
              itemCount: chatC.messages.length,
              itemBuilder: (context, idx) {
                final m = chatC.messages[idx];
                final isMe = m.senderId == 'me'; // replace with actual user id check
                return MessageBubble(text: m.text, isMe: isMe, time: m.createdAt);
              },
            );
          })),
          SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: TextField(controller: txtC, decoration: InputDecoration(hintText: 'Type a message')),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final text = txtC.text.trim();
                    if (text.isEmpty) return;
                    chatC.sendMessage(chatId, 'me', text); // replace 'me' with real senderId
                    txtC.clear();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}