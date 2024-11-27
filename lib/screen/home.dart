import 'package:flutter/material.dart';

import 'package:vision_one_4o/widgets/ui/home/bottom_panel.dart';
import 'package:vision_one_4o/widgets/ui/home/functions.dart';
import 'package:vision_one_4o/widgets/ui/home/home_hero.dart';
import 'package:vision_one_4o/widgets/ui/home/netrunners.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        const Funcitons(),
        Netrunners(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        BottomPanel(screenWidth: screenWidth, screenHeight: screenHeight)
      ],
    );
  }
}
