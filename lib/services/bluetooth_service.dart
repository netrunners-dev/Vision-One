import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vision_one/utils/utility.dart';

abstract class _BluetoothService {
  Future<bool> connectTo(String address);
  Future<bool> disconnect();
  Stream<BluetoothState> connectionState();
  Future<List<BluetoothDevice>> getDevices();

  void write(String message);
}

class BluetoothService implements _BluetoothService {
  final flutterBluetoothSerial = FlutterBluetoothSerial.instance;
  late BluetoothConnection bluetoothConnection;

  @override
  Future<List<BluetoothDevice>> getDevices() async {
    List<BluetoothDevice> devices =
        await flutterBluetoothSerial.getBondedDevices();
    try {
      if (devices.isNotEmpty) {
        return devices;
      }
    } on PlatformException {
      Utility.showToast("PlatformException");
    }

    return [];
  }

  @override
  Future<bool> connectTo(String address) async {
    if (Platform.isAndroid) {
      bool isBluetoothScanPermissionGranted =
          await Permission.bluetoothScan.request().isGranted;
      bool isBluetoothPermissionGranted =
          await Permission.bluetooth.request().isGranted;
      bool isBluetoothConnectPermissionGranted =
          await Permission.bluetoothConnect.request().isGranted;

      if (!isBluetoothPermissionGranted) {
        await Permission.bluetooth.request();
      }

      if (!isBluetoothScanPermissionGranted) {
        await Permission.bluetoothScan.request();
      }

      if (!isBluetoothConnectPermissionGranted) {
        await Permission.bluetoothConnect.request();
      }
    }

    var isBluetoothEnabled = await flutterBluetoothSerial.isEnabled ?? false;

    if (!isBluetoothEnabled) {
      Utility.showToast("Bluetooth is not enabled 🔷");

      return false;
    }

    try {
      bluetoothConnection = await BluetoothConnection.toAddress(address);
      return bluetoothConnection.isConnected;
    } catch (e) {
      Utility.showToast("Connection error due: $e");

      return false;
    }
  }

  @override
  Stream<BluetoothState> connectionState() {
    return flutterBluetoothSerial.onStateChanged();
  }

  @override
  void write(String message) {
    if (bluetoothConnection.isConnected) {
      try {
        bluetoothConnection.output.add(utf8.encode(message));
      } catch (e) {
        Utility.showToast("Error during write: $e");
      }
    } else {
      print("Connection is not established");
    }
  }

  @override
  Future<bool> disconnect() async {
    if (bluetoothConnection.isConnected) {
      await bluetoothConnection.close();
      return true;
    }
    return false;
  }
}
