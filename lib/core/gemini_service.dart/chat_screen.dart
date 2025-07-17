import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

// import '/core/gemini_service/chat_message.dart';
import '/core/gemini_service.dart/chat_bubble.dart';
import '/core/gemini_service.dart/chat_view_model.dart';


class ChatScreen extends StatefulWidget {
  final Function(bool) onThemeToggle;
  final bool isDarkMode;

  const ChatScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final FlutterTts _flutterTts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  Uint8List? _selectedImage;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final Uint8List bytes = await image.readAsBytes();
      setState(() {
        _selectedImage = bytes;
      });
    }
  }

  Future<void> _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (val) {
          setState(() {
            _textController.text = val.recognizedWords;
          });
        },
        localeId: "uz_UZ",
      );
    }
  }

  Future<void> _speakText(String text) async {
    await _flutterTts.setLanguage("uz-UZ");
    await _flutterTts.speak(text);
  }

  void _sendMessage(ChatViewModel viewModel) async {
    final String inputText = _textController.text.trim();
    if (inputText.isEmpty && _selectedImage == null) return;

    await viewModel.sendMessage(inputText, _selectedImage);
    _textController.clear();
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatViewModel = Provider.of<ChatViewModel>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'AI Chat',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Switch(
            value: widget.isDarkMode,
            onChanged: widget.onThemeToggle,
            activeColor: Colors.white,
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            tooltip: 'Barchasini tozalash',
            onPressed: chatViewModel.clearMessages,
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4A90E2), Color(0xFF007AFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: chatViewModel.messages.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ScaleTransition(
                            scale: _scaleAnimation,
                            child: Icon(
                              Icons.chat_outlined,
                              size: 70,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Suhbatni boshlang",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Yozing, gapiring yoki rasm tanlang",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.all(12),
                      itemCount: chatViewModel.messages.length,
                      itemBuilder: (context, index) {
                        final message =
                            chatViewModel.messages[chatViewModel
                                    .messages
                                    .length -
                                1 -
                                index];
                        return ChatBubble(
                          message: message,
                          onSpeak: message.isUser
                              ? null
                              : () => _speakText(message.text),
                        );
                      },
                    ),
            ),
            if (chatViewModel.isLoading)
              const Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 10),
                    Text(
                      "AI yozmoqda...",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10.0,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.image, color: Color(0xFF4A90E2)),
                    onPressed: _pickImage,
                  ),
                  IconButton(
                    icon: Icon(
                      _isListening ? Icons.mic_off : Icons.mic,
                      color: const Color(0xFF4A90E2),
                    ),
                    onPressed: _startListening,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      onSubmitted: (_) => _sendMessage(chatViewModel),
                      decoration: InputDecoration(
                        hintText: _selectedImage != null
                            ? 'Rasmga izoh yozing...'
                            : 'Xabar yozing...',
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      maxLines: null,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFF4A90E2)),
                    onPressed: chatViewModel.isLoading
                        ? null
                        : () => _sendMessage(chatViewModel),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
