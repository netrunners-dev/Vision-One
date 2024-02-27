import 'package:flutter/material.dart';

class BatteryPercentage extends StatefulWidget {
  const BatteryPercentage({super.key, required this.batteryPercentage});

  final int batteryPercentage;

  @override
  State<BatteryPercentage> createState() => _BatteryPercentageState();
}

class _BatteryPercentageState extends State<BatteryPercentage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 38,
          height: 19,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3),
            color: widget.batteryPercentage > 20
                ? const Color.fromARGB(255, 119, 239, 63)
                : const Color.fromARGB(255, 239, 63, 64),
            borderRadius: const BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        ),
        Text(
          "${widget.batteryPercentage}%",
          textAlign: TextAlign.center,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 20,
          ),
        )
      ],
    );
  }
}
