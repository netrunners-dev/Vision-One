import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BatteryReset extends StatelessWidget {
  const BatteryReset(
      {super.key, required this.screenWidth, required this.screenHeight});

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Refresh");
      },
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
