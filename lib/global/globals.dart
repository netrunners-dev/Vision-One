import 'package:shared_preferences/shared_preferences.dart';
import 'package:vision_one/services/bluetoothService.dart';

class Globals {
  static BluetoothService bluetooth = BluetoothService();
  static Future<SharedPreferences> prefs = SharedPreferences.getInstance();
}
