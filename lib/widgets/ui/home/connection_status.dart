import 'package:flutter/material.dart';
import 'package:vision_one/global/globals.dart';

class ConnectionStatus extends StatefulWidget {
  const ConnectionStatus({super.key});

  @override
  State<ConnectionStatus> createState() => _ConnectionStatusState();
}

class _ConnectionStatusState extends State<ConnectionStatus> {
  bool isConnected = false;

  void isConnectedF() async {
    var isEnabled = Globals.bluetooth.bluetoothConnection.isConnected;

    setState(() {
      isConnected = isEnabled;
    });
  }

  @override
  void initState() {
    isConnectedF();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "status:",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
            height: 1,
          ),
        ),
        Text(
          isConnected ? "CONNECTED" : "DISCONNECTED",
          style: TextStyle(
            fontSize: isConnected ? 17 : 12.5,
            color: isConnected
                ? const Color.fromARGB(255, 119, 239, 63)
                : const Color.fromARGB(255, 239, 63, 64),
            height: 1,
          ),
        )
      ],
    );
  }
}
