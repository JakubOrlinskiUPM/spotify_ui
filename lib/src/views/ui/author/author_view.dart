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

class AuthorView extends StatefulWidget {
  const AuthorView({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<AuthorView> createState() => _AuthorViewState();
}

class _AuthorViewState extends State<AuthorView> {
  double expandedHeight = 300;
  var top = 0.0;

  Author? author;

  @override
  void initState() {
    author = BlocProvider.of<DataBloc>(context).getAuthorById(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (author == null) {
      return const AuthorViewLoading();
    }

    Playlist playlist =
        BlocProvider.of<DataBloc>(context).getAuthorTopPlaylist(author!);

    List<Playlist> albums =
        BlocProvider.of<DataBloc>(context).getAuthorAlbums(author!);

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
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
              background: CachedNetworkImage(
                imageUrl: author!.imageUrl,
                fit: BoxFit.cover,
              ),
              title: Opacity(
                opacity: frac < 1 ? 0 : 1,
                child: Text(author!.name),
              ),
            );
          }),
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
                    song: playlist.songs![index],
                    playlist: playlist,
                  ),
                ],
              );
            },
            childCount: min(playlist.songs!.length, 5),
          ),
        ),
        SliverToBoxAdapter(
          child: Text("Popular releases"),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return AlbumItemAuthor(item: albums[index]);
            },
            childCount: min(albums.length, 4),
          ),
        ),
        SliverToBoxAdapter(
          child: OutlinedButton(
            onPressed: _showDiscography,
            child: Text("See discography"),
          ),
        ),
      ],
    );
  }

  void _showDiscography() {}
}
