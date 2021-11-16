import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotify_ui/src/business_logic/blocs/player_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/album.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';

class PlaybackSheet extends StatefulWidget {
  const PlaybackSheet({Key? key}) : super(key: key);

  @override
  _PlaybackSheetState createState() => _PlaybackSheetState();
}

class _PlaybackSheetState extends State<PlaybackSheet> {
  double sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(builder: (context, state) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff057cc9),
                Color(0xff000000),
              ],
              stops: [
                0,
                0.5
              ]),
        ),
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text("title"),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.more_vert, size: 28),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://i1.wp.com/theseconddisc.com/wp-content/uploads/John-Coltrane-Another-Side-of-John-Coltrane.jpg?fit=1500%2C1472&ssl=1',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: const [Text("title"), Text("author")],
                      ),
                      const Icon(CupertinoIcons.heart),
                    ],
                  ),
                  Slider(
                    value: sliderValue,
                    onChanged: _onChanged,
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.shuffle),
                        onPressed: _onShufflePressed,
                      ),
                      IconButton(
                        icon: Icon(Icons.home),
                        onPressed: _onBackPressed,
                      ),
                      IconButton(
                        icon: Icon(Icons.pause),
                        onPressed: () => _onPlayPressed(context, state),
                      ),
                      IconButton(
                        icon: Icon(Icons.forward),
                        onPressed: _onForwardPressed,
                      ),
                      IconButton(
                        icon: Icon(Icons.repeat),
                        onPressed: _onRepeatPressed,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void _onChanged(double value) {}

  void _onShufflePressed() {}

  void _onBackPressed() {}

  void _onPlayPressed(BuildContext context, PlayerState state) {
    Song s = const Song(
      album: Album(
        coverUrl: '',
        title: '',
        id: 1,
        authors: [],
      ),
      id: 1,
      title: 'Song Title',
      authors: [],
      storageUrl:
          'https://firebasestorage.googleapis.com/v0/b/flutterapp-7eda9.appspot.com/o/songs%2FMoose%20Dowa-Alleycat%20Jazz.mp3?alt=media&token=ceab75c2-e9a3-4f02-9fcc-1fc4d1488e67',
    );

    Playlist p = Playlist(title: '', coverUrl: '', id: 1, authors: []);

    if (state.status != PlayerStatus.playing) {
      context.read<PlayerBloc>().add(PlayerSetSongEvent(playlist: p, song: s));
      context.read<PlayerBloc>().add(PlayerStartedEvent());

      state.audioPlayer.onAudioPositionChanged.listen((Duration position) => {
            setState(() {
              sliderValue = state.duration != null
                  ? position.inMilliseconds /
                      state.duration!.inMilliseconds
                  : 0;
              print("set state ${sliderValue}");

            })
          });
    } else {
      context.read<PlayerBloc>().add(PlayerStoppedEvent());
    }
  }

  void _onForwardPressed() {}

  void _onRepeatPressed() {}
}
