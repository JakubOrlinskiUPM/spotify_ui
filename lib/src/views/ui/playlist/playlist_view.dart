import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/views/ui/components/song_item.dart';
import 'package:spotify_ui/src/views/ui/playback/playback_bottom_sheet.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({Key? key, required this.playlist}) : super(key: key);

  final Playlist? playlist;

  @override
  _PlaylistViewState createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  var top = 0.0;
  num minFrac = 0.85;

  @override
  Widget build(BuildContext context) {
    if (widget.playlist == null) {
      return Container();
    }

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.black,
          pinned: true,
          expandedHeight: 300,
          flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            top = constraints.biggest.height;
            var frac =
                MediaQuery.of(context).padding.top + kToolbarHeight / top;
            var opacity = max(0, (frac - minFrac) / (1 - minFrac)).toDouble();
            return FlexibleSpaceBar(
              title: Opacity(
                opacity: opacity,
                child: Text(widget.playlist!.title),
              ),
              background: FractionallySizedBox(
                alignment: Alignment.topCenter,
                heightFactor: 1 - frac,
                child: Hero(
                  tag: (widget.playlist?.id.toString() ?? "") + "-hero",
                  child: CachedNetworkImage(
                      fit: BoxFit.fitHeight,
                      imageUrl: widget.playlist!.coverUrl),
                ),
              ),
            );
          }),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.playlist!.title),
                Text(widget.playlist!.authorString),
                Row(
                  children: [
                    IconButton(
                        onPressed: _heartPressed,
                        icon: const Icon(CupertinoIcons.heart)),
                    IconButton(
                        onPressed: _downloadPressed,
                        icon: const Icon(CupertinoIcons.arrow_down_circle)),
                    IconButton(
                        onPressed: _menuPressed,
                        icon: const Icon(Icons.more_vert)),
                  ],
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return SongItem(
                song: widget.playlist!.songs[index],
                playlist: widget.playlist!,
              );
            },
            childCount: widget.playlist!.songs.length,
          ),
        ),
      ],
    );
  }

  void _heartPressed() {}

  void _downloadPressed() {}

  void _menuPressed() {}
}
