import 'package:flutter/material.dart';
import 'package:vision_one/widgets/radio_buttons.dart';

class MacroSettings extends StatefulWidget {
  const MacroSettings(
      {super.key, required this.setActiveMacro, required this.activeMacro});

  final Function(Modes macro) setActiveMacro;
  final Modes activeMacro;

  @override
  State<MacroSettings> createState() => _MacroSettingsState();
}

enum Modes { music, stt, aia }

class _MacroSettingsState extends State<MacroSettings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioOption<Modes>(
          gropuValue: widget.activeMacro,
          onChanged: (Modes? value) {
            widget.setActiveMacro(value!);
          },
          text: "AI mode",
          value: Modes.aia,
        ),
        RadioOption<Modes>(
          gropuValue: widget.activeMacro,
          onChanged: (Modes? value) {
            setState(() {
              widget.setActiveMacro(value!);
            });
          },
          text: "speech to text mode",
          value: Modes.stt,
        ),
        RadioOption<Modes>(
          gropuValue: widget.activeMacro,
          onChanged: (Modes? value) {
            setState(() {
              widget.setActiveMacro(value!);
            });
          },
          text: "MUSIC MODE",
          value: Modes.music,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
