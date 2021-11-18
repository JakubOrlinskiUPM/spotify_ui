import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:spotify_ui/src/business_logic/blocs/player_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/album.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:spotify_ui/src/views/ui/playback/playback_marquee.dart';
import 'package:spotify_ui/src/views/ui/playback/playback_slider.dart';

class PlaybackSheet extends StatefulWidget {
  const PlaybackSheet({Key? key}) : super(key: key);

  @override
  _PlaybackSheetState createState() => _PlaybackSheetState();
}

class _PlaybackSheetState extends State<PlaybackSheet> {
  static const double ICON_SIZE = 50;

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          PlaybackMarquee(text: "text"),
                          Text("author"),
                        ],
                      ),
                      const Icon(CupertinoIcons.heart),
                    ],
                  ),
                  PlaybackSlider(state: state),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildShuffle(state),
                      IconButton(
                        iconSize: ICON_SIZE,
                        icon: const Icon(Icons.skip_previous),
                        onPressed: _onBackPressed,
                      ),
                      _buildPlay(state),
                      IconButton(
                        iconSize: ICON_SIZE,
                        icon: const Icon(Icons.skip_next),
                        onPressed: _onForwardPressed,
                      ),
                      _buildRepeat(state),
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

  Widget _buildPlay(PlayerState state) {
    if (state.status == PlayerStatus.playing) {
      return IconButton(
        iconSize: 1.5 * ICON_SIZE,
        icon: const Icon(Icons.pause_circle_filled_outlined),
        onPressed: () => _onPlayPressed(context, state),
      );
    } else {
      return IconButton(
        iconSize: 1.5 * ICON_SIZE,
        icon: const Icon(Icons.play_circle_fill_outlined),
        onPressed: () => _onPlayPressed(context, state),
      );
    }
  }

  Widget _buildShuffle(PlayerState state) {
    IconData id;
    Color c;

    switch (state.shuffle) {
      case PlayerShuffle.off:
        id = Icons.shuffle;
        c = Colors.white;
        break;
      case PlayerShuffle.on:
        id = Icons.shuffle;
        c = Colors.green;
        break;
      default:
        id = Icons.shuffle;
        c = Colors.white;
    }

    return IconButton(
      color: c,
      iconSize: 0.6 * ICON_SIZE,
      icon: Icon(id),
      onPressed: _onShufflePressed,
    );
  }

  Widget _buildRepeat(PlayerState state) {
    Color c;
    IconData id;
    switch (state.repeat) {
      case PlayerRepeat.off:
        c = Colors.white;
        id = Icons.repeat;
        break;
      case PlayerRepeat.playlist:
        c = Colors.green;
        id = Icons.repeat;
        break;
      case PlayerRepeat.song:
        c = Colors.green;
        id = Icons.repeat;
        break;
      default:
        c = Colors.white;
        id = Icons.repeat;
    }

    return IconButton(
      color: c,
      iconSize: 0.6 * ICON_SIZE,
      icon: Icon(id),
      onPressed: _onShufflePressed,
    );
  }

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
    } else {
      context.read<PlayerBloc>().add(PlayerStoppedEvent());
    }
  }

  void _onForwardPressed() {}

  void _onRepeatPressed() {}
}
