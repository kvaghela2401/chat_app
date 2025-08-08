import 'package:get/get.dart';
import '../services/api_service.dart';

class AuthController extends GetxController {
  final ApiService _api = ApiService();
  var token = ''.obs;
  var isLoading = false.obs;

  Future<bool> login(String email, String password) async {
    try {
      isLoading.value = true;
      final res = await _api.login(email, password);
      token.value = res['token'] ?? '';
      return token.isNotEmpty;
    } catch (e) {
      print(e);
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}