import 'package:flutter/material.dart';
import 'package:vision_one/widgets/functions/ai_assistant.dart';
import 'package:vision_one/widgets/functions/music.dart';
import 'package:vision_one/widgets/functions/speech_to_text.dart';

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

  void onModeChange(String mode) {
    setState(() {
      activeModes.forEach((key, value) {
        activeModes[key] = (key == mode) ? !value : false;
      });

      areAllModesDisabled =
          activeModes.entries.every((element) => element.value == false);
    });
  }

  @override
  Widget build(BuildContext context) {
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
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        Transcribe(
          isActive: activeModes["stt"]!,
          changeMode: onModeChange,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        AIAssistant(
          isActive: activeModes["aia"]!,
          changeMode: onModeChange,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
      ],
    );
  }
}
