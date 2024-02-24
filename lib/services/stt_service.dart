import 'package:speech_to_text/speech_to_text.dart';

abstract class _STTService {
  void initSpeech();
  void startListening();
  void stopListening();
}

class STTService implements _STTService {
  final SpeechToText _speechToText = SpeechToText();

  bool speechEnabled = false;
  String wordsSpoken = "";

  @override
  void initSpeech() async {
    speechEnabled = await _speechToText.initialize();
  }

  @override
  void startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    speechEnabled = true;
  }

  @override
  void stopListening() async {
    await _speechToText.stop();
    speechEnabled = false;
  }

  void _onSpeechResult(result) {
    wordsSpoken = '${result.recognizedWords}';
    // Globals.bluetooth.write(_wordsSpoken);
    // print(wordsSpoken);
  }
}
