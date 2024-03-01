import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class STTProvider extends ChangeNotifier {
  final SpeechToText speechToText = SpeechToText();

  bool speechEnabled = false;
  String wordsSpoken = "";

  void initSpeech() async {
    await speechToText.initialize();
    notifyListeners();
  }

  void startListening(bool stt) async {
    await speechToText.listen(
        onResult: (result) => _onSpeechResult(result, stt));
    speechEnabled = true;
    notifyListeners();
  }

  void stopListening() async {
    await speechToText.stop();
    speechEnabled = false;
    notifyListeners();
  }

  void _onSpeechResult(result, stt) {
    wordsSpoken = '${result.recognizedWords}';
  }

  void resetSpokenWords() {
    wordsSpoken = "";
  }

  void setSpeechEnabled(bool isEnabled) {
    speechEnabled = isEnabled;
    notifyListeners();
  }
}
