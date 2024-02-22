import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vision_one/global/globals.dart';
import 'package:vision_one/widgets/ui/settings/bluetooth_switch.dart';

class MacConnect extends StatefulWidget {
  const MacConnect({
    super.key,
    required this.macAddressController,
    required this.isEnabled,
    required this.onChange,
  });

  final TextEditingController macAddressController;
  final bool isEnabled;
  final Function(bool value) onChange;

  @override
  State<MacConnect> createState() => _MacConnectState();
}

class _MacConnectState extends State<MacConnect> {
  String initValue = '';

  @override
  void initState() {
    _getMacAddress();
    super.initState();
  }

  Future<void> _getMacAddress() async {
    final SharedPreferences localStorage = await Globals.prefs;
    final String macAddress = (localStorage.getString("mac") ?? "");

    setState(() {
      widget.macAddressController.text = macAddress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MaskedTextField(
            textCapitalization: TextCapitalization.characters,
            controller: widget.macAddressController,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            style: const TextStyle(
              fontSize: 22,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              filled: true,
              fillColor: const Color.fromARGB(255, 255, 255, 255),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1000),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1000),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
            ),
            mask: "##:##:##:##:##:##",
            maskFilter: {"#": RegExp(r'^[0-9a-zA-Z]+$')},
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        BluetoothSwitch(
          value: widget.isEnabled ? true : false,
          onChange: widget.onChange,
        )
      ],
    );
  }
}
