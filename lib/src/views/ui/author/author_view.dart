import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/author.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/views/ui/author/album_item_author.dart';
import 'package:spotify_ui/src/views/ui/author/author_view_loading.dart';
import 'package:spotify_ui/src/views/ui/author/song_item_author.dart';
import 'package:spotify_ui/src/views/ui/components/custom_future_builder.dart';
import 'package:spotify_ui/src/views/ui/components/fade_header.dart';

class AuthorView extends StatefulWidget {
  const AuthorView({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<AuthorView> createState() => _AuthorViewState();
}

class _AuthorViewState extends State<AuthorView> {
  double expandedHeight = 300;
  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<Author>(
      future: BlocProvider.of<DataBloc>(context).getAuthorById(widget.id),
      child: (Author author) => CustomFutureBuilder<Playlist>(
        future: BlocProvider.of<DataBloc>(context).getAuthorPlaylist(author),
        child: (Playlist playlist) => CustomScrollView(
          slivers: <Widget>[
            FadeHeader(
              title: author.name,
              imageUrl: author.imageUrl,
              heroString: author.heroString,
              imageFullSize: true,
            ),
            SliverToBoxAdapter(),
            SliverToBoxAdapter(
              child: Text("Popular"),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text((index + 1).toString()),
                      SongItemAuthor(
                        song: playlist.songs[index],
                        playlist: playlist,
                      ),
                    ],
                  );
                },
                childCount: min(playlist.songs.length, 5),
              ),
            ),
            SliverToBoxAdapter(
              child: Text("Releases"),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return AlbumItemAuthor(id: author.albums[index]);
                },
                childCount: min(author.albums.length, 4),
              ),
            ),
            SliverToBoxAdapter(
              child: OutlinedButton(
                onPressed: _showDiscography,
                child: Text("See discography"),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 10000),
            ),
          ],
        ),
      ),
    );
  }

  void _showDiscography() {}
}
