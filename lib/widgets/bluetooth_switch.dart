import 'package:flutter/material.dart';
import 'package:vision_one/main.dart';

class BluetoothSwitch extends StatefulWidget {
  const BluetoothSwitch(
      {super.key, required this.value, required this.onChange});

  final bool value;
  final Function(bool) onChange;

  @override
  State<BluetoothSwitch> createState() => _BluetoothSwitchState();
}

class _BluetoothSwitchState extends State<BluetoothSwitch> {
  late bool isEnabled;

  @override
  Widget build(BuildContext context) {
    isEnabled = widget.value;
    final MaterialStateProperty<Color?> trackColor =
        MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        // Track color when the switch is selected.
        if (states.contains(MaterialState.selected)) {
          return const Color.fromARGB(255, 119, 239, 63);
        }

        return const Color.fromARGB(255, 239, 63, 64);
      },
    );
    final MaterialStateProperty<Color?> overlayColor =
        MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        return null;
      },
    );

    return Switch(
      value: isEnabled,
      overlayColor: overlayColor,
      trackColor: trackColor,
      trackOutlineColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        return Colors.orange.withOpacity(0); // Use the default color.
      }),
      thumbColor: const MaterialStatePropertyAll<Color>(Colors.white),
      onChanged: widget.onChange,
    );
  }
}
