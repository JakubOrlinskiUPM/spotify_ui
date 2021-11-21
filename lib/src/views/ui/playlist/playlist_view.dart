import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/views/ui/components/song_item.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({Key? key, required this.playlist}) : super(key: key);

  final Playlist? playlist;

  @override
  _PlaylistViewState createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  @override
  Widget build(BuildContext context) {
    if (widget.playlist == null) {
      return Container();
    }

    return Column(
      children: [
        CachedNetworkImage(imageUrl: widget.playlist!.coverUrl),
        Text(widget.playlist!.title),
        Text(widget.playlist!.authorString),
        Expanded(
          child: ListView.builder(
            itemCount: widget.playlist!.songs.length,
            itemBuilder: (BuildContext context, int index) {
              return SongItem(song: widget.playlist!.songs[index]);
            },
          ),
        ),
      ],
    );
  }
}
