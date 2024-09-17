import 'package:flutter/material.dart';
import '../../api/gemini_api.dart';
import '../../data/database/entity/chat.dart';

class ChatViewModel extends ChangeNotifier {
  List<Chat> chatList = [];
  String prompt = '';
  bool isLoading = false;

  final TextEditingController textController = TextEditingController();

  void updatePrompt(String value) {
    prompt = value;
    notifyListeners();
  }

  Future<void> sendPrompt() async {
    if (textController.text.isEmpty) return;

    addPrompt(textController.text);
    prompt = '';
    textController.clear(); // Limpar o campo após enviar
    isLoading = true;
    notifyListeners();

    final chatResponse = await GeminiApi.getResponse(textController.text);
    chatList.insert(0, chatResponse);

    isLoading = false;
    notifyListeners();
  }

  void addPrompt(String prompt) {
    chatList.insert(0, Chat(prompt: prompt, isFromUser: true));
    notifyListeners();
  }
}
