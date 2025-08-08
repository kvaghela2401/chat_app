import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
// TODO: change to your API base URL
  final String baseUrl = 'https://yourapi.com/api';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final resp = await http.post(Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}));
    if (resp.statusCode == 200) {
      return jsonDecode(resp.body);
    }
    throw Exception('Login failed: ${resp.body}');
  }

  Future<List<dynamic>> getChats(String token) async {
    final resp = await http.get(Uri.parse('$baseUrl/chats'), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    });
    if (resp.statusCode == 200) return jsonDecode(resp.body);
    throw Exception('Failed to load chats');
  }

  Future<List<dynamic>> getMessages(String token, String chatId) async {
    final resp = await http.get(Uri.parse('$baseUrl/messages?chatId=$chatId'), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    });
    if (resp.statusCode == 200) return jsonDecode(resp.body);
    throw Exception('Failed to load messages');
  }
}