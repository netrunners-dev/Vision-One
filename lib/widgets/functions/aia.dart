import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AIA extends StatefulWidget {
  const AIA({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.changeMode,
    required this.isActive,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final Function(String) changeMode;
  final bool isActive;

  @override
  _AIAState createState() => _AIAState();
}

class _AIAState extends State<AIA> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.screenHeight / 2.2,
      right: 45,
      child: InkWell(
        onTap: () {
          widget.changeMode("aia");
        },
        child: AnimatedContainer(
          width: 70,
          height: 70,
          margin: widget.isActive
              ? const EdgeInsets.only(top: 2)
              : const EdgeInsets.all(0),
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          padding: const EdgeInsets.fromLTRB(16, 18, 17, 13),
          decoration: BoxDecoration(
            color: widget.isActive
                ? const Color.fromARGB(255, 119, 239, 63)
                : const Color.fromARGB(255, 239, 63, 64),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(1, 3),
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: SvgPicture.asset(
            'assets/icons/ai_icon.svg',
            width: 35,
            height: 35,
          ),
        ),
      ),
    );
  }
}
