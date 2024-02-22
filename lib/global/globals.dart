import 'package:shared_preferences/shared_preferences.dart';

import 'package:vision_one/services/bluetooth_service.dart';
import 'package:vision_one/services/stt_service.dart';

class Globals {
  static BluetoothService bluetooth = BluetoothService();
  static STTService stt = STTService();
  static Future<SharedPreferences> prefs = SharedPreferences.getInstance();
}
