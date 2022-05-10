import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spotify_ui/src/views/ui/routing.dart';

class SidescrollingListItem extends StatelessWidget {
  const SidescrollingListItem({Key? key, required this.item}) : super(key: key);

  final item;

  @override
  Widget build(BuildContext context) {
    return _buildPlaylistItem(context);
  }

  Widget _buildPlaylistItem(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: () =>
          _onButtonPressed(context, PLAYLIST_VIEW_ROUTE + "/${item.id}"),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Hero(
                tag: item.heroString,
                child: CachedNetworkImage(imageUrl: item.coverUrl)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 3),
            child: Text(item.title),
          ),
          Text(item.authorString,
              style: Theme.of(context).textTheme.caption),
        ],
      ),
    );
  }

  void _onButtonPressed(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}
