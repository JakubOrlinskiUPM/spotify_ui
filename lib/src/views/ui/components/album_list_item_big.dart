import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spotify_ui/src/views/ui/routing.dart';
import 'package:uuid/uuid.dart';

class AlbumListItemBig extends StatelessWidget {
  const AlbumListItemBig({Key? key, required this.item}) : super(key: key);

  final item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        onPressed: () =>
            _onButtonPressed(context, PLAYLIST_VIEW_ROUTE + "/${item.id}"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              child: CachedNetworkImage(imageUrl: item.imageUrl),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 3),
              child: Text(
                item.name,
                softWrap: true,
              ),
            ),
            Text(
              item.authorString,
              style: Theme.of(context).textTheme.caption,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }

  void _onButtonPressed(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}
