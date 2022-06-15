import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:spotify_ui/src/views/ui/components/custom_future_builder.dart';
import 'package:spotify_ui/src/views/ui/components/middle_dot.dart';
import 'package:spotify_ui/src/views/ui/components/song_item.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  _PlaylistViewState createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  var top = 0.0;
  num minFrac = 0.85;
  double expandedHeight = 300;

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<Playlist>(
      future: BlocProvider.of<DataBloc>(context).getPlaylistById(widget.id),
      child: (Playlist playlist) => CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Color(playlist.colorHex),
            pinned: true,
            expandedHeight: expandedHeight,
            flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              top = constraints.biggest.height;
              var frac = top / (expandedHeight + kToolbarHeight);
              frac = (frac - 0.3) / (1 - 0.3);
              frac = frac.clamp(0, 1);
              frac = 1 - frac;

              return FlexibleSpaceBar(
                title: Opacity(
                  opacity: frac < 1 ? 0 : 1,
                  child: Text(playlist.title),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(playlist.colorHex), Colors.black],
                    ),
                  ),
                  child: SafeArea(
                    child: FractionallySizedBox(
                      alignment: Alignment.topCenter,
                      heightFactor: 1 - frac,
                      child: Hero(
                        tag: playlist.heroString,
                        child: CachedNetworkImage(
                            fit: BoxFit.fitHeight, imageUrl: playlist.coverUrl),
                      ),
                    ),
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
                  Text(
                    playlist.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    playlist.authorString,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
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
            padding: EdgeInsets.only(bottom: 60),
            sliver: CustomFutureBuilder<List<Song>>(
              future: BlocProvider.of<DataBloc>(context)
                  .getPlaylistSongs(widget.id),
              child: (List<Song> songs) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return SongItem(
                      song: songs[index],
                      playlist: playlist,
                    );
                  },
                  childCount: songs.length,
                ),
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
