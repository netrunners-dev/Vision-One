import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:vision_one/global/globals.dart';
import 'package:vision_one/widgets/settings/info.dart';
import 'package:vision_one/widgets/settings/mac.dart';
import 'package:vision_one/widgets/settings/macro.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Modes _activeMacro = Modes.aia;
  TextEditingController _macAddressController = TextEditingController();
  bool isEnabled = false;

  void setActiveMacro(Modes macro) {
    setState(() {
      _activeMacro = macro;
    });
  }

  void onChange(bool value) {
    setState(() {
      isEnabled = value;
    });
  }

  void applySettings() {
    final RegExp _macRegex =
        RegExp(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
    if (!_macRegex.hasMatch(_macAddressController.text)) {
      Fluttertoast.showToast(
        msg: "Mac address is not valid",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16,
      );
      return;
    }

    if (isEnabled) {
      Globals.bluetooth.connectTo(_macAddressController.text);

      if (Globals.bluetooth.bluetoothConnection.isConnected) {
        Fluttertoast.showToast(
          msg: "Successfully connected",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16,
        );
        Globals.bluetooth.write("c12:30");
      } else {
        Fluttertoast.showToast(
          msg: "Failed to connect",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16,
        );
      }
    } else {
      if (Globals.bluetooth.bluetoothConnection.isConnected) {
        Globals.bluetooth.disconnect();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 95,
          ),
          SvgPicture.asset(
            'assets/images/settings.svg',
            width: screenWidth,
          ),
          const SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "mac address",
              style: TextStyle(
                color: const Color.fromARGB(255, 239, 63, 64),
                fontSize: 17,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          MacAndBT(
            isEnabled: isEnabled,
            macAddressController: _macAddressController,
            onChange: onChange,
          ),
          const SizedBox(
            height: 28,
          ),
          const Divider(
            color: Color.fromARGB(255, 239, 63, 64),
          ),
          const SizedBox(
            height: 28,
          ),
          const SoftwareInfo(),
          const SizedBox(
            height: 28,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "MACRO FUNCTION:",
              style: TextStyle(
                color: const Color.fromARGB(255, 239, 63, 64),
                fontSize: 17,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: MacroSettings(
              activeMacro: _activeMacro,
              setActiveMacro: setActiveMacro,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 35),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: applySettings,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 239, 63, 64),
                padding: const EdgeInsets.symmetric(vertical: 13),
              ),
              child: const Text(
                "Apply",
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
            ),
          )
        ],
      ),
    );
  }
}
