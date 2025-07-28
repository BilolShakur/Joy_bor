import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:joy_bor/islom/cappadociModel.dart';

class CappadociService {
  static Future<CappadociModel> getById(int id) async {
    try {
      final url = Uri.parse('http://13.232.21.244:3000/api/locations/$id');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return CappadociModel.fromJson(jsonBody);
      } else if (response.statusCode == 404) {
        throw Exception('❌ Ma’lumot topilmadi (404)');
      } else {
        throw Exception('❌ Xatolik: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('❌ Internet yoki server bilan muammo: $e');
    }
  }
}
