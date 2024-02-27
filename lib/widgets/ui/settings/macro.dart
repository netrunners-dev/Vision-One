import 'package:flutter/material.dart';
import 'package:vision_one/widgets/ui/settings/radio_buttons.dart';

class MacroSettings extends StatefulWidget {
  const MacroSettings(
      {super.key, required this.setActiveMacro, required this.activeMacro});

  final Function(String macro) setActiveMacro;
  final String activeMacro;

  @override
  State<MacroSettings> createState() => _MacroSettingsState();
}

class _MacroSettingsState extends State<MacroSettings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioOption<String>(
          gropuValue: widget.activeMacro,
          onChanged: (value) {
            widget.setActiveMacro(value!);
          },
          text: "AI mode",
          value: "a",
        ),
        RadioOption<String>(
          gropuValue: widget.activeMacro,
          onChanged: (value) {
            setState(() {
              widget.setActiveMacro(value!);
            });
          },
          text: "speech to text mode",
          value: "s",
        ),
        RadioOption<String>(
          gropuValue: widget.activeMacro,
          onChanged: (value) {
            setState(() {
              widget.setActiveMacro(value!);
            });
          },
          text: "MUSIC MODE",
          value: "m",
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
