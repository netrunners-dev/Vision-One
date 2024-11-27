import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:app_settings/app_settings.dart';
import 'package:provider/provider.dart';
import 'package:vision_one_4o/global/globals.dart';
import 'package:vision_one_4o/providers/speech_to_text_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dart_openai/dart_openai.dart';

import 'package:vision_one_4o/screen/tabs.dart';

late bool isEnabled;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((fn) async {
    isEnabled =
        await Globals.bluetooth.flutterBluetoothSerial.isEnabled ?? false;

    if (!isEnabled) {
      AppSettings.openAppSettings(type: AppSettingsType.bluetooth);
    }

    await dotenv.load(fileName: "lib/.env");
    OpenAI.apiKey = dotenv.env["OPEN_AI_API_KEY"]!;

    runApp(const App());
  });
}

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 239, 63, 64));

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => STTProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: "Pixel").copyWith(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: kColorScheme.primary,
            selectionColor: kColorScheme.primary.withOpacity(.3),
            selectionHandleColor: kColorScheme.primary,
          ),
        ),
        home: const TabsScreen(),
      ),
    );
  }
}
