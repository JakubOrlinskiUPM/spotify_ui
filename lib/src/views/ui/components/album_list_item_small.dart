import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spotify_ui/src/views/ui/routing.dart';

class AlbumListItemSmall extends StatelessWidget {
  const AlbumListItemSmall({Key? key, required this.item}) : super(key: key);

  static double height = 70;

  final item;

  @override
  Widget build(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width / 2;
    itemWidth -= height;
    itemWidth -= 10;
    itemWidth -= 8;

    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: () =>
          _onButtonPressed(context, PLAYLIST_VIEW_ROUTE + "/${item.id}"),      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: height,
          color: Colors.grey.shade800,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: height,
                height: height,
                child: Hero(
                  tag: item.heroString,
                  child: CachedNetworkImage(imageUrl: item.imageUrl, fit: BoxFit.fill),
                ),
              ),
              SizedBox(
                width: itemWidth,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item.name),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onButtonPressed(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}
