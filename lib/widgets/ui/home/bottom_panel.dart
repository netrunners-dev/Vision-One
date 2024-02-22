import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vision_one/widgets/ui/home/batery_refresh.dart';
import 'package:vision_one/widgets/ui/home/battery_percentage.dart';
import 'package:vision_one/widgets/ui/home/connection_status.dart';

class BottomPanel extends StatelessWidget {
  const BottomPanel(
      {super.key, required this.screenWidth, required this.screenHeight});

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
          top: screenHeight / 1.4,
          left: 40,
          width: screenWidth / 2.05,
          child: Image.asset("assets/images/full_glasses.png"),
        ),

        Positioned(
            top: screenHeight / 1.355,
            right: 60,
            child: Column(
              children: [
                BatteryReset(
                    screenHeight: screenHeight, screenWidth: screenWidth),
                const SizedBox(
                  height: 10,
                ),
                const ConnectionStatus(),
              ],
            )),

        // Battery percentage
        Positioned(
          top: screenHeight / 1.57,
          right: screenWidth > 400 ? 60 : 58,
          child: const BatteryPercentage(),
        ),
      ],
    );
  }
}
