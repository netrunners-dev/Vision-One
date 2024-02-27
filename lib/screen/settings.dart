import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vision_one/global/globals.dart';
import 'package:vision_one/widgets/ui/settings/info.dart';
import 'package:vision_one/widgets/ui/settings/mac_connect.dart';
import 'package:vision_one/widgets/ui/settings/macro.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _activeMacro = '';
  final TextEditingController _macAddressController = TextEditingController();
  bool isEnabled = false;

  void setActiveMacro(String macro) async {
    final SharedPreferences localStorage = await Globals.prefs;
    _activeMacro = macro;
    localStorage.setString('macro', macro);
    setState(() {});
  }

  void onChange(bool value) {
    setState(() {
      isEnabled = value;
    });
  }

  void isConnected() async {
    bool isConnected = Globals.bluetooth.bluetoothConnection.isConnected;

    setState(() {
      isEnabled = isConnected;
    });
  }

  void initMacro() async {
    final SharedPreferences localStorage = await Globals.prefs;
    String macro = (localStorage.getString("macro") ?? "");

    if (macro == '') {
      localStorage.setString('macro', 'a');
      _activeMacro = 'a';
    }

    setActiveMacro(macro);
  }

  @override
  void initState() {
    isConnected();
    initMacro();
    super.initState();
  }

  void applySettings() async {
    final SharedPreferences localStorage = await Globals.prefs;
    String mac = (localStorage.getString("mac") ?? "");

    if (mac == '' || mac != _macAddressController.text) {
      localStorage.setString('mac', _macAddressController.text);
    }

    final RegExp macRegex =
        RegExp(r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
    if (!macRegex.hasMatch(_macAddressController.text)) {
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

      await Future.delayed(const Duration(seconds: 3));
      if (Globals.bluetooth.bluetoothConnection.isConnected) {
        await Fluttertoast.showToast(
          msg: "Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16,
        );

        DateTime now = DateTime.now();
        String time = DateFormat('kk:mm').format(now);
        String macro = (localStorage.getString("macro") ?? "a");

        Globals.bluetooth.write("x$macro$time");
      }
    } else {
      if (Globals.bluetooth.bluetoothConnection.isConnected) {
        Globals.bluetooth.disconnect();

        Fluttertoast.showToast(
          msg: "Disconnected",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16,
        );
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
          MacConnect(
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
