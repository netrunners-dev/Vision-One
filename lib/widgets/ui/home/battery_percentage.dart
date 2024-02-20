import 'package:flutter/material.dart';

class BatteryPercentage extends StatefulWidget {
  const BatteryPercentage({super.key});

  @override
  State<BatteryPercentage> createState() => _BatteryPercentageState();
}

class _BatteryPercentageState extends State<BatteryPercentage> {
  var batteryPercentage = 99;

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
            color: const Color.fromARGB(255, 119, 239, 63),
            borderRadius: const BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        ),
        Text(
          "$batteryPercentage%",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
          ),
        )
      ],
    );
  }
}
