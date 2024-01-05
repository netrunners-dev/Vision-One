import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

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
      Fluttertoast.showToast(
        msg: "PlatformException",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16,
      );
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
      Fluttertoast.showToast(
        msg: "Bluetooth is not enabled",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16,
      );

      return false;
    }

    try {
      bluetoothConnection = await BluetoothConnection.toAddress(address);
      return bluetoothConnection.isConnected;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Connection error due: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16,
      );

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
        Fluttertoast.showToast(
          msg: "Error during write: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Connection is not established",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16,
      );
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
