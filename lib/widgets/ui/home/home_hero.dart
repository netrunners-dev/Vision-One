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
            top: screenHeight / 7.9,
            right: 77,
            child: const Row(
              textBaseline: TextBaseline.ideographic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(
                  "ver 0.1",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "a",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -(screenHeight / 10),
            right: 0,
            width: screenWidth + 10,
            child: Image.asset("assets/images/half_glasses.png"),
          ),
        ],
      ),
    );
  }
}
