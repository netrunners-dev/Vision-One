import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MusicFN extends StatefulWidget {
  const MusicFN({
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
  _MusicFNState createState() => _MusicFNState();
}

class _MusicFNState extends State<MusicFN> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.screenHeight / 2.2,
      left: 45,
      child: InkWell(
        onTap: () {
          widget.changeMode("music");
          if (!widget.isActive) return;
        },
        child: AnimatedContainer(
          width: 70,
          height: 70,
          margin: widget.isActive
              ? const EdgeInsets.only(top: 2)
              : const EdgeInsets.all(0),
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          padding: const EdgeInsets.fromLTRB(17, 19, 18, 14),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(1, 3),
              ),
            ],
            color: widget.isActive
                ? const Color.fromARGB(255, 119, 239, 63)
                : const Color.fromARGB(255, 239, 63, 64),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: SvgPicture.asset(
            'assets/icons/music_icon.svg',
            width: 30,
            height: 30,
          ),
        ),
      ),
    );
  }
}
