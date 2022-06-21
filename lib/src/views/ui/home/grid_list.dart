import 'package:flutter/material.dart';
import 'package:spotify_ui/src/views/ui/home/album_list_item_small.dart';

class GridList extends StatelessWidget {
  const GridList({Key? key, required this.name, required this.list})
      : super(key: key);

  final String name;
  final List list;

  @override
  Widget build(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width / 2;
    double itemHeight = AlbumListItemSmall.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(name, style: Theme.of(context).textTheme.headline5),
          ),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: list.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: itemWidth / itemHeight,
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return AlbumListItemSmall(recentlyPlayed: list[index]);
            },
          ),
        ],
      ),
    );
  }
}
