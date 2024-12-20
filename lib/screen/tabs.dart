import 'package:flutter/material.dart';

import 'package:vision_one_4o/screen/home.dart';
import 'package:vision_one_4o/screen/settings.dart';
import 'package:vision_one_4o/screen/creators.dart';
import 'package:vision_one_4o/widgets/ui/nav.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
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
    Widget currentScreen = const HomeScreen();

    if (newScreen == "home") {
      setState(() {
        currentScreen = const HomeScreen();
      });
    } else if (newScreen == "user") {
      setState(() {
        currentScreen = const CreatorsScreen();
      });
    } else if (newScreen == "settings") {
      setState(() {
        currentScreen = const SettingsScreen();
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
