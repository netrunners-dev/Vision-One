import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_one/global/globals.dart';
import 'package:nowplaying/nowplaying.dart';
import 'package:vision_one/widgets/ui/music/music_button.dart';

class MusicMacro extends StatefulWidget {
  const MusicMacro({
    super.key,
    required this.changeMode,
    required this.isActive,
  });

  final Function(String) changeMode;
  final bool isActive;

  @override
  State<MusicMacro> createState() => _MusicMacroState();
}

class _MusicMacroState extends State<MusicMacro> {
  int counter = 1;
  int prevCounter = 0;

  @override
  void initState() {
    super.initState();
    customInterval();
    NowPlaying.instance.start();
    NowPlaying.instance.isEnabled().then((bool isEnabled) async {
      if (!isEnabled) {
        await NowPlaying.instance.requestPermissions();
      }
    });
  }

  void customInterval() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      counter += 1;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<NowPlayingTrack>.value(
      initialData: NowPlayingTrack.loading,
      value: NowPlaying.instance.stream,
      child: Consumer<NowPlayingTrack>(builder: (context, track, _) {
        // if (track == NowPlayingTrack.loading) return Container();

        if (counter > prevCounter && widget.isActive) {
          if (track.isStopped) {
            return MusicButton(
              changeMode: widget.changeMode,
              isActive: widget.isActive,
            );
          }

          String artist = track.artist ?? "";
          String songName = track.title ?? "";
          String progress =
              track.progress.toString().split('.').first.substring(2);
          String duration =
              track.duration.toString().split('.').first.substring(2);

          Globals.bluetooth.write("m$artist|$songName|$progress/$duration");

          prevCounter++;
        }

        return MusicButton(
          changeMode: widget.changeMode,
          isActive: widget.isActive,
        );
      }),
    );
  }
}
