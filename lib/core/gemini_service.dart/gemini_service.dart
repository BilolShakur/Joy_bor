import 'dart:typed_data';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService {
  final Gemini _gemini = Gemini.instance;

  Future<String> getResponse({
    required String text,
    Uint8List? imageBytes,
  }) async {
    var response;
    if (imageBytes != null && text.isNotEmpty) {
      response = await _gemini.textAndImage(text: text, images: [imageBytes]);
    } else if (text.isNotEmpty) {
      response = await _gemini.text(text);
    } else if (imageBytes != null) {
      response = await _gemini.textAndImage(
        text: 'Bu rasmdagi nima?',
        images: [imageBytes],
      );
    }

    if (response != null &&
        response.content?.parts != null &&
        response.content!.parts!.isNotEmpty) {
      return response.content!.parts!.last.text ??
          'Javob topilmadi. Qayta urinib ko‘ring.';
    }
    return 'Javob topilmadi. Qayta urinib ko‘ring.';
  }
}
