import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vision_one/global/globals.dart';

class BatteryReset extends StatefulWidget {
  const BatteryReset({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.setBatteryPercentage,
  });

  final double screenWidth;
  final double screenHeight;
  final Function(int) setBatteryPercentage;

  @override
  State<BatteryReset> createState() => _BatteryResetState();
}

class _BatteryResetState extends State<BatteryReset> {
  RegExp regex = RegExp(r'b([0-9]|[1-9][0-9]|100)');
  String message = '';

  void updateBatteryPercentage() {
    Globals.bluetooth.write("b");
    try {
      Globals.bluetooth.bluetoothConnection.input?.listen((Uint8List data) {
        String dataStr = ascii.decode(data);
        message += dataStr;
        if (dataStr.contains('\n')) {
          if (!regex.hasMatch(message)) {
            message = '';
            return;
          }

          String percentage = message.substring(1);
          widget.setBatteryPercentage(int.parse(percentage).toInt());
          message = '';
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: updateBatteryPercentage,
      child: Container(
        padding: const EdgeInsets.all(6),
        height: 40,
        width: 100,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(40, 0, 0, 0),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(1, 3),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color.fromARGB(255, 239, 63, 64),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/restart.svg',
              width: 21,
              height: 21,
              // ignore: deprecated_member_use
              color: Colors.white,
            ),
            const SizedBox(
              width: 3,
            ),
            const Text(
              "Battery\nStatus",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: .8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
