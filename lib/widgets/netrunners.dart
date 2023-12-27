import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://www.instagram.com/netrunners_dev');

class Netrunners extends StatelessWidget {
  const Netrunners(
      {super.key, required this.screenWidth, required this.screenHeight});

  final double screenWidth;
  final double screenHeight;

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (screenWidth - (screenWidth - 60)) / 2,
      top: screenHeight / 1.68,
      child: Container(
        width: screenWidth / 2 + 22,
        height: 74,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 25),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 30, 30, 30),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
            bottomLeft: Radius.circular(35),
            bottomRight: Radius.circular(17),
          ),
        ),
        child: SvgPicture.asset(
          "assets/images/netrunners.svg",
        ),
      ),
    );
  }
}
