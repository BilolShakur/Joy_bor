import 'package:http/http.dart' as http;
import 'dart:convert';


class AuthService {
  final String baseUrl = 'http://YOUR_BASE_URL/api/auth';

  Future<bool> checkRegister(String email) async {
    final url = Uri.parse('$baseUrl/check-register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    print("check-register status: ${response.statusCode}");
    print("check-register body: ${response.body}");

    if (response.statusCode == 200) {
      return true; // Foydalanuvchi mavjud
    } else if (response.statusCode == 404) {
      return false; // Foydalanuvchi yo‘q, ro'yxatdan o‘tsa bo‘ladi
    } else {
      throw Exception('Xatolik: ${response.statusCode}');
    }
  }

  Future<void> sendOtp(String email) async {
    final url = Uri.parse('$baseUrl/send-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    print("sendOtp status: ${response.statusCode}");
    print("sendOtp body: ${response.body}");

    if (response.statusCode != 201) {
      throw Exception('OTP yuborilmadi: ${response.statusCode}');
    }
  }
}
