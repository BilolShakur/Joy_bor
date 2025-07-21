import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final String baseUrl = 'http://13.232.21.244:3000/api';

  /// Check if user is registered
  Future<bool> checkRegister(String email) async {
    final url = Uri.parse('$baseUrl/auth/check-register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data['isRegister'] == true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }


  Future<bool> createUser({
    required String email,
    required String phoneNumber,
    required String fullName,
    required String country,
    required String city,
    required String zip,
    required String address,
    String? googleId,
    String? imgUrl,
  }) async {
    final url = Uri.parse('$baseUrl/users');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'phone_number': phoneNumber,
          'full_name': fullName,
          'country': country,
          'city': city,
          'zip': zip,
          'address': address,
          'googleId': googleId,
          'img_url': imgUrl,
        }),
      );
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }


  Future<bool> sendOtp(String email) async {
    final url = Uri.parse('$baseUrl/auth/send-otp');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }


  Future<Map<String, dynamic>?> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final url = Uri.parse('$baseUrl/auth/verify-otp');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'otp': otp}),
      );
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        // Save tokens if present
        if (data['user'] != null) {
          final prefs = await SharedPreferences.getInstance();
          if (data['user']['accessToken'] != null) {
            await prefs.setString('token', data['user']['accessToken']);
          }
          if (data['user']['refreshToken'] != null) {
            await prefs.setString('refreshToken', data['user']['refreshToken']);
          }
        }
        return data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Refresh access token using refresh token
  Future<String?> refreshToken() async {
    final url = Uri.parse('$baseUrl/auth/refresh-token-user');
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refreshToken');
      if (refreshToken == null) return null;
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $refreshToken',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['accessToken'] != null) {
          await prefs.setString('token', data['accessToken']);
          return data['accessToken'];
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Log out (clear both tokens)
  Future<bool> logout() async {
    final url = Uri.parse('$baseUrl/auth/log-out-user');
    try {
      final response = await http.post(url);
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('refreshToken');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Update user profile
  Future<bool> updateProfile(Map<String, dynamic> fields) async {
    final url = Uri.parse('$baseUrl/auth/profile-update');
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(fields),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// Get user profile
  Future<Map<String, dynamic>?> getProfile() async {
    final url = Uri.parse('$baseUrl/auth/profile-get');
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
