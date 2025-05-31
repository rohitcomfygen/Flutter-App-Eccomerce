import 'dart:async';

class AuthService {
  static Future<bool> loginUser(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // simulate network delay
    if (email == 'test@gmail.com' && password == '123456') {
      return true;
    } else {
      return false;
    }
  }
}
