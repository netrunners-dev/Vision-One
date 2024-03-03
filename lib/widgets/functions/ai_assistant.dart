import 'dart:async';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vision_one/global/globals.dart';
import 'package:vision_one/providers/speech_to_text_provider.dart';

class AIAssistant extends StatefulWidget {
  const AIAssistant({
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
  State<AIAssistant> createState() => _AIAssistantState();
}

class _AIAssistantState extends State<AIAssistant> {
  bool isConnected = false;
  bool speechWasEnabled = false;

  @override
  void initState() {
    isBtConnected();
    super.initState();
  }

  void isBtConnected() async {
    isConnected = Globals.bluetooth.bluetoothConnection.isConnected;
    setState(() {});
  }

  void aiQuery(String query) async {
    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [OpenAIChatCompletionChoiceMessageContentItemModel.text(query)],
      role: OpenAIChatMessageRole.user,
    );

    OpenAIChatCompletionModel chatCompletion =
        await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo-1106",
      seed: 6,
      messages: [userMessage],
      temperature: 0.2,
      maxTokens: 500,
    );

    final response = chatCompletion.choices.first.message.content?[0].text;

    if (response != null) {
      return Globals.bluetooth.write("at$response");
    }

    Globals.bluetooth.write("No response 😢");
  }

  @override
  Widget build(BuildContext context) {
    String words = context.watch<STTProvider>().wordsSpoken;

    Future.delayed(Duration.zero, () {
      if (widget.isActive && !widget.isMacroClicked) {
        turnOnAI(true);
        widget.setIsMacroClicked(true);
      }

      if (widget.isActive && widget.isListening) {
        speechWasEnabled = true;
      }

      if (widget.isActive && !widget.isListening && speechWasEnabled) {
        Globals.bluetooth.write("aw");
        Timer(const Duration(seconds: 1), () {
          aiQuery("$words, It must be under 208 characters");
        });

        context.read<STTProvider>().resetSpokenWords();
        context.read<STTProvider>().setSpeechEnabled(false);
        speechWasEnabled = false;
        Timer(const Duration(seconds: 7), () {
          widget.changeMode("a");
        });
      }
    });

    return Positioned(
      top: widget.screenHeight / 2.2,
      right: 45,
      child: InkWell(
        onTap: () => turnOnAI(false),
        child: AnimatedContainer(
          width: 70,
          height: 70,
          margin: widget.isActive
              ? const EdgeInsets.only(top: 2)
              : const EdgeInsets.all(0),
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          padding: const EdgeInsets.fromLTRB(16, 18, 17, 13),
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
          child: SvgPicture.asset(
            'assets/icons/ai_icon.svg',
            width: 35,
            height: 35,
          ),
        ),
      ),
    );
  }

  void turnOnAI(bool macro) {
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

    context.read<STTProvider>().resetSpokenWords();

    if (widget.speechEnabled) {
      context.read<STTProvider>().stopListening();
    } else {
      context.read<STTProvider>().startListening(false);
      Globals.bluetooth.write("al");
    }

    if (!macro) {
      widget.changeMode("a");
    }
  }
}
