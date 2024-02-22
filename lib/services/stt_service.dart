import 'package:speech_to_text/speech_to_text.dart';

abstract class _STTService {
  void initSpeech();
  void startListening();
  void stopListening();

  bool isConnected = false;
  bool speechEnabled = false;
}

class STTService implements _STTService {
  final SpeechToText _speechToText = SpeechToText();
  @override
  bool isConnected = false;
  @override
  bool speechEnabled = false;
  String _wordsSpoken = "";

  @override
  void initSpeech() async {
    speechEnabled = await _speechToText.initialize();
  }

  @override
  void startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
  }

  @override
  void stopListening() async {
    await _speechToText.stop();
    speechEnabled = false;
  }

  void _onSpeechResult(result) {
    _wordsSpoken = '${result.recognizedWords}';
    // Globals.bluetooth.write(_wordsSpoken);
    print(_wordsSpoken);
  }
}
