import 'dart:typed_data';
import 'package:flutter/material.dart';
import '/core/gemini_service.dart/chat_message.dart';
import '/core/gemini_service.dart/gemini_service.dart';

class ChatViewModel extends ChangeNotifier {
  final GeminiService _geminiService = GeminiService();

  final List<ChatMessage> messages = [];
  bool isLoading = false;

  Future<void> sendMessage(String text, Uint8List? imageBytes) async {
    if (text.trim().isEmpty && imageBytes == null) return;

    messages.add(ChatMessage(text: text, isUser: true, imageBytes: imageBytes));
    isLoading = true;
    notifyListeners();

    try {
      final aiText = await _geminiService.getResponse(
        text: text,
        imageBytes: imageBytes,
      );

      messages.add(ChatMessage(text: aiText, isUser: false));
    } catch (e) {
      messages.add(
        ChatMessage(
          text: e.toString().contains('429')
              ? "So‘rovlar soni juda ko‘p. Iltimos, biroz kutib qayta urinib ko‘ring."
              : "Xatolik: $e",
          isUser: false,
        ),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearMessages() {
    messages.clear();
    notifyListeners();
  }
}
