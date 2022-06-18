import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:spotify_ui/src/views/ui/components/custom_future_builder.dart';
import 'package:spotify_ui/src/views/ui/components/fade_header.dart';
import 'package:spotify_ui/src/views/ui/components/middle_dot.dart';
import 'package:spotify_ui/src/views/ui/components/song_item.dart';
import 'package:spotify_ui/src/views/ui/playlist/author_list.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  _PlaylistViewState createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<Playlist>(
      future: BlocProvider.of<DataBloc>(context).getPlaylistById(widget.id),
      child: (Playlist playlist) => CustomScrollView(
          slivers: <Widget>[
            FadeHeader(
              title: playlist.name,
              imageUrl: playlist.imageUrl,
              color: playlist.colorHex,
              heroString: playlist.heroString,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      playlist.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    AuthorList(playlist: playlist),
                    Row(
                      children: [
                        Text(
                          playlist.playlistType.string,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        const MiddleDot(),
                        Text(
                          playlist.releaseYear.toString(),
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
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
            SliverPadding(
              padding: EdgeInsets.only(bottom: 1000),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return SongItem(
                      songId: playlist.songIds[index],
                      playlist: playlist,
                    );
                  },
                  childCount: playlist.songIds.length,
                ),
              ),
            ),
          ],
      ),
    );
  }

  void _heartPressed() {}

  void _downloadPressed() {}

  void _menuPressed() {}
}
