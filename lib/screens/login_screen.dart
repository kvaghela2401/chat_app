import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            SizedBox(height: 12),
            TextField(controller: passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Password')),
            SizedBox(height: 20),
            Obx(() => ElevatedButton(
              onPressed: authC.isLoading.value
                  ? null
                  : () async {
                final ok = await authC.login(emailController.text.trim(), passwordController.text.trim());
                if (ok) Get.offNamed('/chats');
                else Get.snackbar('Error', 'Login failed');
              },
              child: authC.isLoading.value ? CircularProgressIndicator() : Text('Login'),
            ))
          ],
        ),
      ),
    );
  }
}