import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/views/ui/components/middle_dot.dart';
import 'package:spotify_ui/src/views/ui/routing.dart';

class AlbumItemAuthor extends StatelessWidget {
  const AlbumItemAuthor({Key? key, required this.item}) : super(key: key);

  static double height = 100;

  final Playlist item;

  @override
  Widget build(BuildContext context) {
    return TextButton(
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
            child: CachedNetworkImage(imageUrl: item.coverUrl, fit: BoxFit.fill,),
          ),
          title: Text(item.title),
          subtitle: Row(
            children: [
              Text(item.releaseYear.toString()),
              const MiddleDot(),
              Text(item.playlistType.string),
            ],
          ),
        ),
      ),
    );
  }

  void _onButtonPressed(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}
