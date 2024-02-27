import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_one/global/globals.dart';
import 'package:vision_one/providers/speech_to_text_provider.dart';
import 'package:vision_one/widgets/functions/ai_assistant.dart';
import 'package:vision_one/widgets/functions/music.dart';
import 'package:vision_one/widgets/functions/speech_to_text.dart';
import 'package:intl/intl.dart';

class Funcitons extends StatefulWidget {
  const Funcitons({super.key});

  @override
  State<Funcitons> createState() => _FuncitonsState();
}

class _FuncitonsState extends State<Funcitons> {
  // Variables
  Map<String, bool> activeModes = {
    "music": false,
    'stt': false,
    'aia': false,
  };
  bool areAllModesDisabled = true;
  String lastTime = "";

  @override
  void initState() {
    clockMode();
    super.initState();
  }

  void onModeChange(String mode) {
    setState(() {
      activeModes.forEach((key, value) {
        activeModes[key] = (key == mode) ? !value : false;
      });

      areAllModesDisabled =
          activeModes.entries.every((element) => element.value == false);
    });
  }

  void clockMode() {
    Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!areAllModesDisabled || !mounted) return;

      DateTime now = DateTime.now();
      String time = DateFormat('kk:mm').format(now);

      lastTime = time;
      Globals.bluetooth.write("c$time");
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<STTProvider>().initSpeech();
    bool isListening = context.watch<STTProvider>().speechToText.isListening;
    bool speechEnabled = context.watch<STTProvider>().speechEnabled;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned(
          top: screenHeight / 2.09,
          left: (screenWidth - (screenWidth - 60)) / 2,
          child: Container(
            width: screenWidth - 60,
            height: 71,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(35),
              ),
            ),
          ),
        ),
        MusicMacro(
          isActive: activeModes["music"]!,
          changeMode: onModeChange,
        ),
        Transcribe(
          isActive: activeModes["stt"]! && isListening,
          changeMode: onModeChange,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          isListening: isListening,
          speechEnabled: speechEnabled,
        ),
        AIAssistant(
          isActive: activeModes["aia"]! && isListening,
          changeMode: onModeChange,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          isListening: isListening,
          speechEnabled: speechEnabled,
        ),
      ],
    );
  }
}
