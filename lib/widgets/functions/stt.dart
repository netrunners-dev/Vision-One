import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vision_one/global/globals.dart';

class STT extends StatefulWidget {
  const STT(
      {super.key,
      required this.screenWidth,
      required this.screenHeight,
      required this.changeMode,
      required this.isActive});

  final double screenWidth;
  final double screenHeight;
  final Function(String) changeMode;
  final bool isActive;

  @override
  State<STT> createState() {
    return _STTState();
  }
}

class _STTState extends State<STT> {
  final SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;
  String _wordsSpoken = "";

  @override
  void initState() {
    initSpeech();
    super.initState();
  }

  void initSpeech() async {
    bool temp = await _speechToText.initialize();
    setState(() {
      _speechEnabled = temp;
    });
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(result) {
    setState(() {
      _wordsSpoken = '${result.recognizedWords}';
    });
    if (Globals.bluetooth.bluetoothConnection.isConnected) {
      Globals.bluetooth.write(_wordsSpoken);
    }
    print(_wordsSpoken);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.screenHeight / 2.2,
      left: (widget.screenWidth - (widget.screenWidth - 240)) / 2,
      right: (widget.screenWidth - (widget.screenWidth - 240)) / 2,
      child: InkWell(
        onTap: () async {
          widget.changeMode("stt");

          if (_speechToText.isListening) {
            _stopListening();
          } else {
            _startListening();
          }
        },
        child: AnimatedContainer(
          width: 70,
          height: 70,
          margin: _speechToText.isListening
              ? const EdgeInsets.only(top: 2)
              : const EdgeInsets.all(0),
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          padding: const EdgeInsets.fromLTRB(13, 15, 14, 12),
          decoration: BoxDecoration(
            color: _speechToText.isListening
                ? const Color.fromARGB(255, 119, 239, 63)
                : const Color.fromARGB(255, 239, 63, 64),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(1, 3),
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/voice_icon.svg',
                width: 40,
                height: 40,
              ),
              const SizedBox(
                width: 7,
              ),
              const Text(
                "Speech\nTo\nText",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: .8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
