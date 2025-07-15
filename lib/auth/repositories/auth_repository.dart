import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final String baseUrl = 'http://13.232.21.244:3000/api';

  /// 📩 Emailga OTP yuborish (signup uchun)
  Future<bool> sendOtp(String email) async {
    final url = Uri.parse('$baseUrl/users/send-otp');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );
      print('📩 sendOtp response: ${response.statusCode} - ${response.body}');
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('❌ sendOtp error: $e');
      return false;
    }
  }

  /// 🟢 Ro'yxatdan o'tish (Sign Up)
  Future<bool> signUpUser({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/auth/log-up-user');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'full_name': fullName,
          'email': email,
          'password': password,
          'confirm_password': password, // ✅ TO‘G‘RI nomlanish
        }),
      );

      print('📤 STATUS: ${response.statusCode}');
      print('📤 BODY: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        final body = jsonDecode(response.body);
        print('❌ Ro‘yxatdan o‘tishda xatolik: ${body['message']}');
        return false;
      }
    } catch (e) {
      print('❌ signUpUser exception: $e');
      return false;
    }
  }

  /// ✅ OTP orqali faollashtirish
  Future<bool> activate({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
    required String otp,
  }) async {
    final url = Uri.parse('$baseUrl/users/activate');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'full_name': fullName,
          'email': email,
          'password': password,
          'confirm_password': confirmPassword, // ✅ mos yozilgan
          'otp': otp,
        }),
      );

      print('✅ activate response: ${response.statusCode} - ${response.body}');
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('❌ activate exception: $e');
      return false;
    }
  }

  /// 🔐 Login qilish
  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/log-in-user');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      print('🔐 login response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          print('✅ Token saqlandi: $token');
          return true;
        } else {
          print('❌ Token mavjud emas');
          return false;
        }
      }
      return false;
    } catch (e) {
      print('❌ login error: $e');
      return false;
    }
  }
}
