import 'package:flutter/material.dart';

class RadioOption<T> extends StatelessWidget {
  const RadioOption({
    super.key,
    required this.gropuValue,
    required this.onChanged,
    required this.text,
    required this.value,
  });

  final T value;
  final T? gropuValue;
  final String text;
  final ValueChanged<T?> onChanged;

  Widget _buildRadioOption() {
    final bool isSelected = value == gropuValue;

    return Container(
      width: 25,
      height: 25,
      decoration:
          const ShapeDecoration(shape: CircleBorder(), color: Colors.white),
      child: Align(
        alignment: Alignment.center,
        child: AnimatedContainer(
          width: 15,
          height: 15,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          decoration: ShapeDecoration(
              shape: const CircleBorder(),
              color: isSelected ? Colors.red : Colors.white),
        ),
      ),
    );
  }

  Widget _buildText() {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 23,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () => onChanged(value),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildRadioOption(),
              const SizedBox(
                width: 14,
              ),
              _buildText()
            ],
          ),
        ),
      ),
    );
  }
}
