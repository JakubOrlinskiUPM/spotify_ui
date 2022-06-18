import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/views/ui/components/custom_future_builder.dart';
import 'package:spotify_ui/src/views/ui/components/middle_dot.dart';
import 'package:spotify_ui/src/views/ui/routing.dart';

class AlbumItemAuthor extends StatelessWidget {
  const AlbumItemAuthor({Key? key, required this.id}) : super(key: key);

  static double height = 100;

  final String id;

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<Playlist>(
      future: BlocProvider.of<DataBloc>(context).getPlaylistById(id),
      child: (Playlist album) => TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        onPressed: () =>
            _onButtonPressed(context, PLAYLIST_VIEW_ROUTE + "/${album.id}"),
        child: Card(
          child: ListTile(
            tileColor: Colors.black,
            contentPadding: EdgeInsets.zero,
            leading: CachedNetworkImage(
              width: height,
              height: height,
              imageUrl: album.imageUrl,
              // fit: BoxFit.fill,
            ),
            title: Text(album.name),
            subtitle: Row(
              children: [
                Text(album.releaseYear.toString()),
                const MiddleDot(),
                Text(album.playlistType.string),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onButtonPressed(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}
