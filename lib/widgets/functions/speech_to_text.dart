import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vision_one/global/globals.dart';
import 'package:vision_one/providers/speech_to_text_provider.dart';

class Transcribe extends StatefulWidget {
  const Transcribe({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.changeMode,
    required this.isActive,
    required this.isListening,
    required this.speechEnabled,
    required this.isMacroClicked,
    required this.setIsMacroClicked,
  });

  final double screenWidth;
  final double screenHeight;

  final Function(String) changeMode;

  final bool isActive;
  final bool isListening;
  final bool speechEnabled;

  final bool isMacroClicked;
  final Function(bool) setIsMacroClicked;

  @override
  State<Transcribe> createState() => _TranscribeState();
}

class _TranscribeState extends State<Transcribe> {
  int counter = 1;
  int prevCounter = 0;

  bool isConnected = false;
  bool speechWasEnabled = false;

  @override
  void initState() {
    isBtConnected();
    customInterval();
    super.initState();
  }

  void isBtConnected() async {
    isConnected = Globals.bluetooth.bluetoothConnection.isConnected;
    setState(() {});
  }

  void customInterval() {
    Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      counter += 1;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    String words = context.read<STTProvider>().wordsSpoken;

    Future.delayed(Duration.zero, () {
      if (widget.isActive && !widget.isMacroClicked) {
        turnOnSpeech(true);
        widget.setIsMacroClicked(true);
      }

      if (widget.isActive && counter > prevCounter && widget.isListening) {
        Globals.bluetooth.write("s$words");
        prevCounter++;
        speechWasEnabled = true;
      }

      if (widget.isActive && !widget.isListening && speechWasEnabled) {
        Globals.bluetooth.write("s$words");
        Timer(const Duration(seconds: 3), () {
          widget.changeMode("s");
        });
        speechWasEnabled = false;
        context.read<STTProvider>().resetSpokenWords();
        context.read<STTProvider>().setSpeechEnabled(false);
      }
    });

    return Positioned(
      top: widget.screenHeight / 2.2,
      left: (widget.screenWidth - (widget.screenWidth - 240)) / 2,
      right: (widget.screenWidth - (widget.screenWidth - 240)) / 2,
      child: InkWell(
        onTap: () => turnOnSpeech(false),
        child: AnimatedContainer(
          width: 70,
          height: 70,
          margin: widget.isActive
              ? const EdgeInsets.only(top: 2)
              : const EdgeInsets.all(0),
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          padding: const EdgeInsets.fromLTRB(13, 15, 14, 12),
          decoration: BoxDecoration(
            color: widget.isActive
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

  void turnOnSpeech(bool macro) {
    if (!isConnected) {
      Fluttertoast.showToast(
        msg: "You must connect to your glasses to use this feature.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16,
      );
      return;
    }

    speechWasEnabled = false;
    context.read<STTProvider>().resetSpokenWords();

    if (widget.speechEnabled) {
      context.read<STTProvider>().stopListening();
    } else {
      context.read<STTProvider>().startListening(true);
    }

    if (!macro) {
      widget.changeMode("s");
    }
  }
}
