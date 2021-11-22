import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:spotify_ui/src/business_logic/blocs/player_bloc.dart';

class SongItem extends StatelessWidget {
  const SongItem({Key? key, required this.song, required this.playlist}) : super(key: key);

  final Playlist playlist;
  final Song song;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _onSongPressed(context),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 8.0),
        leading: SizedBox(
          width: 50,
          height: 50,
          child: CachedNetworkImage(
            imageUrl: song.album.coverUrl,
          ),
        ),
        title: Text(song.title),
        subtitle: Text(song.authorString),
        trailing: Text("hi!"),
      ),
    );
  }

  void _onSongPressed(BuildContext context) {
    context.read<PlayerBloc>().add(PlayerSetSongEvent(song: song, playlist: playlist));
    context.read<PlayerBloc>().add(PlayerStartedEvent());
  }
}
