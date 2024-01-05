import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:vision_one/widgets/battery.dart';
import 'package:vision_one/widgets/functions/aia.dart';
import 'package:vision_one/widgets/functions/music_fn.dart';
import 'package:vision_one/widgets/functions/stt.dart';
import 'package:vision_one/widgets/home_hero.dart';
import 'package:vision_one/widgets/netrunners.dart';
import 'package:vision_one/widgets/status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variables
  Map<String, bool> activeModes = {
    "music": false,
    'stt': false,
    'aia': false,
  };

  bool areAllModesDisabled = true;
  int prevMinute = -1;
  late Timer timer;

  void onModeChange(String mode) {
    setState(() {
      activeModes.forEach((key, value) {
        activeModes[key] = (key == mode) ? !value : false;
      });

      areAllModesDisabled =
          activeModes.entries.every((element) => element.value == false);
    });

    controlTimerAndSendData();
  }

  void writeTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm:ss').format(now);
  }

  void controlTimerAndSendData() {
    if (areAllModesDisabled) {
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        DateTime now = DateTime.now();
        int currentMinute = now.minute;

        if (currentMinute != prevMinute) {
          writeTime();
          prevMinute = currentMinute;
        }
      });
    } else {
      timer.cancel();
    }
  }

  @override
  void initState() {
    if (areAllModesDisabled) {
      writeTime();
      controlTimerAndSendData();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        HomeHero(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
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
        MusicFN(
          isActive: activeModes["music"]!,
          changeMode: onModeChange,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        STT(
          isActive: activeModes["stt"]!,
          changeMode: onModeChange,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        AIA(
          isActive: activeModes["aia"]!,
          changeMode: onModeChange,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        Netrunners(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        // Weird-shaped container
        Positioned(
          top: screenHeight / 1.71,
          left: (screenWidth - (screenWidth - 50)) / 2,
          right: (screenWidth - (screenWidth - 50)) / 2,
          child: SvgPicture.asset(
            "assets/images/bottom_container.svg",
            width: screenWidth,
          ),
        ),
        // Glasses picture
        Positioned(
          top: screenHeight / 1.35,
          left: 45,
          child: Image.asset("assets/images/full_glasses.png"),
        ),
        Positioned(
          top: screenHeight / 1.27,
          right: screenWidth > 400 ? 60 : 55,
          child: const Status(),
        ),
        Positioned(
          top: screenHeight / 1.57,
          right: screenWidth > 400 ? 60 : 58,
          child: const Battery(),
        )
      ],
    );
  }
}
