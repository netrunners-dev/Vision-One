import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

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
    "a": false,
    "s": false,
    "m": false,
  };
  String message = "";
  String macro = "";

  bool areAllModesDisabled = true;
  bool isConnected = false;
  bool isMacroClicked = false;
  bool wasSent = false;

  @override
  void initState() {
    isBtConnected();
    listenForMacro();
    clockMode();
    resetSentTimer();
    super.initState();
  }

  void resetSentTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (wasSent) setWasSent(false);
    });
  }

  void isBtConnected() async {
    isConnected = Globals.bluetooth.bluetoothConnection.isConnected;
    setState(() {});
  }

  void listenForMacro() {
    if (isConnected) {
      try {
        Globals.bluetooth.bluetoothConnection.input?.listen((Uint8List data) {
          String dataStr = ascii.decode(data);
          message += dataStr;
          if (dataStr.contains('\n')) {
            String trimmedMessage = message.trim();
            if (trimmedMessage == "a" && !wasSent) {
              onModeChange("a");
              setIsMacroClicked(false);
              setWasSent(true);
            }

            if (trimmedMessage == "s" && !wasSent) {
              onModeChange("s");
              setIsMacroClicked(false);
              setWasSent(true);
            }

            if (trimmedMessage == "m") {
              onModeChange('m');
            }

            message = '';
          }
        });
      } catch (e) {
        print(e);
      }
    }
  }

  void setIsMacroClicked(bool clicked) {
    isMacroClicked = clicked;
    setState(() {});
  }

  void setWasSent(bool sent) {
    wasSent = sent;
    setState(() {});
  }

  void onModeChange(String mode) {
    activeModes.forEach((key, value) {
      activeModes[key] = (key == mode) ? !value : false;
    });

    areAllModesDisabled =
        activeModes.entries.every((element) => element.value == false);

    setState(() {});
  }

  void clockMode() {
    Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!areAllModesDisabled) return;

      DateTime now = DateTime.now();
      String time = DateFormat('kk:mm').format(now);

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
          isActive: activeModes["m"]!,
          changeMode: onModeChange,
        ),
        Transcribe(
          isActive: activeModes["s"]!,
          changeMode: onModeChange,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          isListening: isListening,
          speechEnabled: speechEnabled,
          isMacroClicked: isMacroClicked,
          setIsMacroClicked: setIsMacroClicked,
        ),
        AIAssistant(
          isActive: activeModes["a"]!,
          changeMode: onModeChange,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          isListening: isListening,
          speechEnabled: speechEnabled,
          isMacroClicked: isMacroClicked,
          setIsMacroClicked: setIsMacroClicked,
        ),
      ],
    );
  }
}
