import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:spotify_ui/src/business_logic/blocs/player_bloc.dart';
import 'package:spotify_ui/src/views/ui/components/menu_dialog.dart';

class SongItem extends StatelessWidget {
  const SongItem({Key? key, required this.song, required this.playlist})
      : super(key: key);

  final Playlist playlist;
  final Song song;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        TextStyle style = TextStyle(
          color: state.song?.id == song.id ? Colors.green : null,
        );

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
            title: Text(
              song.title,
              style: style,
            ),
            subtitle: Text(song.authorString),
            trailing: IconButton(
              onPressed: () => _onMenuPressed(context),
              icon: const Icon(Icons.more_vert),
            ),
          ),
        );
      },
    );
  }

  void _onSongPressed(BuildContext context) {
    context
        .read<PlayerBloc>()
        .add(PlayerSetSongEvent(song: song, playlist: playlist));
    context.read<PlayerBloc>().add(PlayerStartedEvent());
  }

  _onMenuPressed(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.black,
      useRootNavigator: true,
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext ctx) {
        return MenuDialog(
          playlist: playlist,
          song: song,
          navigator: Navigator.of(context),
        );
      },
    );
  }
}
