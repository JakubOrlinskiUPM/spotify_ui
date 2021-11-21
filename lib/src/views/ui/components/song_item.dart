import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';

class SongItem extends StatelessWidget {
  const SongItem({Key? key, required this.song}) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
    );
  }
}
