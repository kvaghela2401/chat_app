import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/login_screen.dart';
import 'screens/chat_list_screen.dart';
import 'controllers/auth_controller.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
Get.put(AuthController()); // initialize AuthController globally
runApp(MyApp());
}

class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return GetMaterialApp(
debugShowCheckedModeBanner: false,
title: 'Flutter Chat Template',
theme: ThemeData(primarySwatch: Colors.blue),
home: LoginScreen(),
getPages: [
GetPage(name: '/login', page: () => LoginScreen()),
GetPage(name: '/chats', page: () => ChatListScreen()),
],
);
}
}



