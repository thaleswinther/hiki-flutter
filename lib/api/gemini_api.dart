import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:async';

import '../data/database/entity/chat.dart';

class GeminiApi {

  static const String apiKey = 'AIzaSyBQ2VvBlRkktZRVdybk60XgGDTKrF-tJA8';

  static final GenerativeModel _generativeModel = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: apiKey,
  );

  static Future<Chat> getResponse(String prompt) async {
    try {
      final response = await _generativeModel.generateContent([Content.text(prompt)]);
      return Chat(prompt: response.text ?? 'error', isFromUser: false);
    } catch (e) {
      return Chat(prompt: e.toString(), isFromUser: false);
    }
  }
}
