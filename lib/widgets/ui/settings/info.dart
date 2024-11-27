import 'package:flutter/material.dart';

class SoftwareInfo extends StatelessWidget {
  const SoftwareInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                "Software ver:",
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
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "0.2A",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                "FIRMWARE ver:",
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
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "1.0.0",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
