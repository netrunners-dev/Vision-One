import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vision_one/global/globals.dart';
import 'package:vosk_flutter/vosk_flutter.dart';

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
  final vosk = VoskFlutterPlugin.instance();
  final _modelLoader = ModelLoader();
  final sampleRate = 16000;
  var _model;

  @override
  void initState() {
    loadModel();
    print(_model);

    super.initState();
  }

  void loadModel() async {
    await _modelLoader
        .loadFromAssets('assets/model/vosk-model.zip')
        .then((value) => _model = value);
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

          // if (!Globals.bluetooth.bluetoothConnection.isConnected) return;
          print('$_model ?????????????????????????????');

          final recognizer = await vosk.createRecognizer(
            model: _model,
            sampleRate: sampleRate,
          );

          final speechService = await vosk.initSpeechService(recognizer);
          speechService.onPartial().forEach((partial) => print(partial));
          speechService.onResult().forEach((result) => print(result));
          await speechService.start();

          // Globals.bluetooth.write("c02:10");
        },
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
}
