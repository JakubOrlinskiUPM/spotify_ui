import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spotify_ui/src/business_logic/models/author_stub.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/views/ui/routing.dart';

class AuthorList extends StatelessWidget {
  const AuthorList({Key? key, required this.playlist}) : super(key: key);

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (AuthorStub as in playlist.authors) ...[
          TextButton.icon(
            icon: CircleAvatar(
              radius: 12,
              backgroundImage: CachedNetworkImageProvider(
                as.imageUrl,
              ),
            ),
            label: Text(
              as.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            onPressed: () {
              _navigateToArtist(context, as.id);
            },
          ),
        ]
      ],
    );
  }

  _navigateToArtist(BuildContext context, String authorId) {
    String path = AUTHOR_VIEW_ROUTE + "/" + authorId;
    Navigator.of(context).pushNamed(path);
  }
}
