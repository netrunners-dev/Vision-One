import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vision_one/widgets/ui/home/batery_refresh.dart';
import 'package:vision_one/widgets/ui/home/battery_percentage.dart';
import 'package:vision_one/widgets/ui/home/connection_status.dart';

class BottomPanel extends StatefulWidget {
  const BottomPanel(
      {super.key, required this.screenWidth, required this.screenHeight});

  final double screenWidth;
  final double screenHeight;

  @override
  State<BottomPanel> createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  int batteryPercentage = 100;

  void setBatteryPercentage(int percent) {
    batteryPercentage = percent;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Weird-shaped container
        Positioned(
          top: widget.screenHeight / 1.71,
          left: (widget.screenWidth - (widget.screenWidth - 50)) / 2,
          right: (widget.screenWidth - (widget.screenWidth - 50)) / 2,
          child: SvgPicture.asset(
            "assets/images/bottom_container.svg",
            width: widget.screenWidth,
          ),
        ),

        // Glasses picture
        Positioned(
          top: widget.screenHeight / 1.4,
          left: 40,
          width: widget.screenWidth / 2.05,
          child: Image.asset("assets/images/full_glasses.png"),
        ),

        Positioned(
          top: widget.screenHeight / 1.355,
          right: 60,
          child: Column(
            children: [
              BatteryReset(
                screenHeight: widget.screenHeight,
                screenWidth: widget.screenWidth,
                setBatteryPercentage: setBatteryPercentage,
              ),
              const SizedBox(
                height: 10,
              ),
              const ConnectionStatus(),
            ],
          ),
        ),

        // Battery percentage
        Positioned(
          top: widget.screenHeight / 1.57,
          right: widget.screenWidth > 400 ? 60 : 58,
          child: BatteryPercentage(batteryPercentage: batteryPercentage),
        ),
      ],
    );
  }
}
