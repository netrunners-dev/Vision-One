import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key, required this.onSwitchScreen});

  final Function(String newScreen) onSwitchScreen;

  @override
  State<Navbar> createState() {
    return _NavbarState();
  }
}

class _NavbarState extends State<Navbar> {
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey userKey = GlobalKey();
  final GlobalKey settingsKey = GlobalKey();

  // Variables for AnimatedPositioned element
  double posTop = 13.4;
  double posLeft = 20;
  bool initPosLeft = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 400 && !initPosLeft) {
      setState(() {
        posLeft = 20;
        initPosLeft = true;
      });
    }

    return Container(
      color: const Color.fromARGB(255, 239, 63, 64),
      child: Stack(
        children: [
          Container(
            height: 81,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 30, 30, 30),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
          ),
          AnimatedPositioned(
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 150),
            top: posTop,
            left: posLeft,
            child: Container(
              height: 54,
              width: 54,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
            ),
          ),
          Container(
            height: 81,
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  key: homeKey,
                  onTap: () {
                    widget.onSwitchScreen("home");
                    RenderBox renderBox =
                        homeKey.currentContext!.findRenderObject() as RenderBox;
                    Offset globalOffset = renderBox.localToGlobal(Offset.zero);
                    setState(() {
                      posLeft = globalOffset.dx - 14;
                    });
                  },
                  child: SvgPicture.asset(
                    'assets/icons/home_icon.svg',
                    width: 25,
                    height: 25,
                    fit: BoxFit.cover,
                  ),
                ),
                InkWell(
                  key: userKey,
                  onTap: () {
                    widget.onSwitchScreen("user");
                    RenderBox renderBox =
                        userKey.currentContext!.findRenderObject() as RenderBox;
                    Offset globalOffset = renderBox.localToGlobal(Offset.zero);
                    setState(() {
                      posLeft = globalOffset.dx - 14.5;
                    });
                  },
                  child: SvgPicture.asset(
                    'assets/icons/accounts_icon.svg',
                    width: 25,
                    height: 25,
                    fit: BoxFit.cover,
                  ),
                ),
                InkWell(
                  key: settingsKey,
                  onTap: () {
                    widget.onSwitchScreen("settings");
                    RenderBox renderBox = settingsKey.currentContext!
                        .findRenderObject() as RenderBox;
                    Offset globalOffset = renderBox.localToGlobal(Offset.zero);
                    setState(() {
                      posLeft = globalOffset.dx - 14;
                    });
                  },
                  child: SvgPicture.asset(
                    'assets/icons/settings_icon.svg',
                    width: 25,
                    height: 25,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
