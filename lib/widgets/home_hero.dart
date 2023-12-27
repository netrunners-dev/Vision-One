import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeHero extends StatelessWidget {
  const HomeHero(
      {super.key, required this.screenWidth, required this.screenHeight});

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 60),
      child: Stack(
        children: [
          Positioned(
            left: (screenWidth - (screenWidth - 50)) / 2,
            top: screenHeight / 25,
            child: SvgPicture.asset(
              "assets/images/vision_one.svg",
              width: screenWidth - 50,
            ),
          ),
          Positioned(
            top: screenHeight / 8,
            right: 77,
            child: const Text(
              "ver 0.1a",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
          Positioned(
            top: screenHeight / 12,
            right: 0,
            child: Image.asset("assets/images/glasses.png"),
          ),
        ],
      ),
    );
  }
}
