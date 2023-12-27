import 'package:flutter/material.dart';

import 'package:vision_one/screen/home.dart';
import 'package:vision_one/screen/settings.dart';
import 'package:vision_one/screen/user.dart';
import 'package:vision_one/widgets/nav.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  var newScreen = "home";

  void _switchScreen(String screenIndex) {
    setState(() {
      newScreen = screenIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = HomeScreen();

    if (newScreen == "home") {
      setState(() {
        currentScreen = HomeScreen();
      });
    } else if (newScreen == "user") {
      setState(() {
        currentScreen = const UserScreen();
      });
    } else if (newScreen == "settings") {
      setState(() {
        currentScreen = const SettingsScreen();
      });
    }

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 30, 30, 30),
              Color.fromARGB(255, 239, 63, 64)
            ],
            begin: Alignment.center,
            end: Alignment.bottomCenter,
          ),
        ),
        child: currentScreen,
      ),
      bottomNavigationBar: Navbar(onSwitchScreen: _switchScreen),
    );
  }
}
