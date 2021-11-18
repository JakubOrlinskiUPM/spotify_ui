import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotify_ui/src/business_logic/blocs/player_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/album.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';

class PlaybackControls extends StatelessWidget {
  const PlaybackControls({Key? key, required this.state}) : super(key: key);
  static const double ICON_SIZE = 50;
  final PlayerState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildShuffle(state),
        IconButton(
          iconSize: ICON_SIZE,
          icon: const Icon(Icons.skip_previous),
          onPressed: _onBackPressed,
        ),
        _buildPlay(context, state),
        IconButton(
          iconSize: ICON_SIZE,
          icon: const Icon(Icons.skip_next),
          onPressed: _onForwardPressed,
        ),
        _buildRepeat(state),
      ],
    );
  }


  Widget _buildPlay(BuildContext context, PlayerState state) {
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
      padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
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
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 8.0),
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
