import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final String baseUrl = "http://13.232.21.244:3000/api";

  /// 1. Email ro'yxatdan o‘tganmi — tekshiradi
  Future<bool> isRegistered(String email) async {
    try {
      final url = Uri.parse('$baseUrl/auth/check-register');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      print("check-register status: ${response.statusCode}");
      print("check-register body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['isExist'] ?? false;
      } else {
        return false;
      }
    } catch (e) {
      print("isRegistered Exception: $e");
      return false;
    }
  }

  /// 2. OTP yuboradi
  Future<bool> sendOtp(String email) async {
    try {
      final url = Uri.parse('$baseUrl/auth/send-otp');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      print("sendOtp status: ${response.statusCode}");
      print("sendOtp body: ${response.body}");

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("sendOtp Exception: $e");
      return false;
    }
  }

  /// 3. OTP'ni tekshiradi va tokenni saqlaydi
  Future<bool> verifyOtp({required String email, required String otp}) async {
    print("----------------------------------------------------------------");
    print(otp);
    print(email);
    print("----------------------------------------------------------------");
    try {
      final url = Uri.parse('$baseUrl/auth/verify-otp');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'otp': otp}),
      );

      print("verifyOtp status: ${response.statusCode}");
      print("verifyOtp body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        final token = data['accessToken'];
        print('Token: ${data['accessToken']}');

        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          print("Token saqlandi: $token");
          return true;
        } else {
          print("Token null chiqdi");
        }
      }
      return false;
    } catch (e) {
      print("verifyOtp Exception: $e");
      return false;
    }
  }

  /// 4. Login funksiyasi
  Future<bool> login(String email, String password) async {
    try {
      final url = Uri.parse('$baseUrl/auth/login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      print("login status: ${response.statusCode}");
      print("login body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['access_token'];

        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          print("Login token saqlandi: $token");
          return true;
        }
      }
      return false;
    } catch (e) {
      print("login Exception: $e");
      return false;
    }
  }

  /// 5. Tokenni olish
  Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('token');
    } catch (e) {
      print("getToken Exception: $e");
      return null;
    }
  }
}
