import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ChatListScreen extends StatelessWidget {
  final AuthController authC = Get.find();

  @override
  Widget build(BuildContext context) {
// for demo, a static list of chats
    final chats = List.generate(5, (i) => {'id': '$i', 'name': 'User $i'});

    return Scaffold(
      appBar: AppBar(title: Text('Chats')),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, idx) {
          final c = chats[idx];
          return ListTile(
            title: Text(c['name']!),
            onTap: () => Get.toNamed('/chat', arguments: {'chatId': c['id'], 'name': c['name']}),
          );
        },
      ),
    );
  }
}