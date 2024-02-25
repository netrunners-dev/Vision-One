import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vision_one/global/globals.dart';
import 'package:nowplaying/nowplaying.dart';

class MusicMacro extends StatefulWidget {
  const MusicMacro({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.changeMode,
    required this.isActive,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final Function(String) changeMode;
  final bool isActive;

  @override
  State<MusicMacro> createState() => _MusicMacroState();
}

class _MusicMacroState extends State<MusicMacro> {
  bool isConnected = false;
  @override
  void initState() {
    super.initState();
    NowPlaying.instance.start();
    isBtConnected();
    NowPlaying.instance.isEnabled().then((bool isEnabled) async {
      if (!isEnabled) {
        final shown = await NowPlaying.instance.requestPermissions();
        print('MANAGED TO SHOW PERMS PAGE: $shown');
      }
    });
  }

  void isBtConnected() async {
    isConnected = Globals.bluetooth.bluetoothConnection.isConnected;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<NowPlayingTrack>.value(
      initialData: NowPlayingTrack.loading,
      value: NowPlaying.instance.stream,
      child: Consumer<NowPlayingTrack>(builder: (context, track, _) {
        // if (track == NowPlayingTrack.loading) return Container();
        print(track.title);

        return Positioned(
          top: widget.screenHeight / 2.2,
          left: 45,
          child: InkWell(
            onTap: () {
              if (!isConnected) {
                Fluttertoast.showToast(
                  msg: "You must connect to your glasses to use this feature.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16,
                );
                return;
              }

              widget.changeMode("music");
            },
            child: AnimatedContainer(
              width: 70,
              height: 70,
              margin: widget.isActive
                  ? const EdgeInsets.only(top: 2)
                  : const EdgeInsets.all(0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              padding: const EdgeInsets.fromLTRB(17, 19, 18, 14),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(1, 3),
                  ),
                ],
                color: widget.isActive
                    ? const Color.fromARGB(255, 119, 239, 63)
                    : const Color.fromARGB(255, 239, 63, 64),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: SvgPicture.asset(
                'assets/icons/music_icon.svg',
                width: 30,
                height: 30,
              ),
            ),
          ),
        );
      }),
    );
  }
}
