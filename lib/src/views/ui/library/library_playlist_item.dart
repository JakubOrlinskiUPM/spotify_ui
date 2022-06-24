import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/user_playlist.dart';
import 'package:spotify_ui/src/views/ui/components/custom_future_builder.dart';
import 'package:spotify_ui/src/views/ui/components/middle_dot.dart';
import 'package:spotify_ui/src/views/ui/routing.dart';
import 'package:spotify_ui/src/business_logic/models/playlist_type.dart';

class LibraryPlaylistItem extends StatelessWidget {
  const LibraryPlaylistItem({Key? key, required this.item}) : super(key: key);

  static double height = 60;

  final UserPlaylist item;

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<Playlist>(
      future: BlocProvider.of<DataBloc>(context).getPlaylistById(item.id),
      child: (Playlist playlist) => TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: () =>
          _onButtonPressed(context, PLAYLIST_VIEW_ROUTE + "/${item.id}"),
      child: Card(
        child: ListTile(
          tileColor: Colors.black,
          contentPadding: EdgeInsets.zero,
          leading: SizedBox(
            width: height,
            height: height,
            child: CachedNetworkImage(imageUrl: playlist.imageUrl, fit: BoxFit.fill,),
          ),
          title: Text(playlist.name),
          subtitle: Row(
            children: [
              Text(playlist.playlistType.string),
              const MiddleDot(),
              Text(playlist.authorString),
            ],
          ),
        ),),
      ),
    );
  }

  void _onButtonPressed(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}
