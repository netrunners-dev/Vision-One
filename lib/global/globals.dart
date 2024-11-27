import 'package:shared_preferences/shared_preferences.dart';

import 'package:vision_one_4o/services/bluetooth_service.dart';

class Globals {
  static BluetoothService bluetooth = BluetoothService();
  static Future<SharedPreferences> prefs = SharedPreferences.getInstance();
}
