import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';

import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:spotify_ui/src/business_logic/blocs/player_bloc.dart';
import 'package:spotify_ui/src/views/ui/components/custom_future_builder.dart';
import 'package:spotify_ui/src/views/ui/components/menu_dialog.dart';

class SongItem extends StatelessWidget {
  const SongItem({Key? key, required this.songId, required this.playlist})
      : super(key: key);

  final Playlist playlist;
  final String songId;

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<Song>(
      future: BlocProvider.of<DataBloc>(context).getSong(songId),
      child: (Song song) => BlocBuilder<PlayerBloc, PlayerState>(
        builder: (context, state) {
          TextStyle style = TextStyle(
            color: state.song?.id == song.id ? Colors.green : null,
          );

          return TextButton(
            onPressed: () => _onSongPressed(context, song),
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 8.0),
              leading: SizedBox(
                width: 50,
                height: 50,
                child: Hero(
                  tag: song.heroString,
                  child: CachedNetworkImage(
                    imageUrl: song.album.imageUrl,
                  ),
                ),
              ),
              title: Text(
                song.name,
                style: style,
              ),
              subtitle: Text(song.authorString),
              trailing: IconButton(
                onPressed: () => _onMenuPressed(context, song),
                icon: const Icon(Icons.more_vert),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onSongPressed(BuildContext context, Song song) {
    context
        .read<PlayerBloc>()
        .add(PlayerSetSongEvent(song: song, playlist: playlist));
    context.read<PlayerBloc>().add(PlayerStartedEvent());
  }

  _onMenuPressed(BuildContext context, Song song) async {
    Route<MenuDialogReturn> route = MaterialPageRoute<MenuDialogReturn>(
      builder: (BuildContext context) {
        return MenuDialog(
          playlist: playlist,
          song: song,
        );
      },
      fullscreenDialog: true,
    );

    MenuDialogReturn? value =
        await Navigator.of(context, rootNavigator: true).push(route);
    if (value != null) {
      Navigator.of(context).pushNamed(value.route, arguments: value.arguments);
    }
  }
}
