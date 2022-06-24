import 'package:flutter/material.dart';

import 'package:spotify_ui/src/views/ui/components/album_list_item_big.dart';

class SidescrollingList extends StatelessWidget {
  const SidescrollingList({Key? key, required this.name, required this.list})
      : super(key: key);

  final String name;
  final List list;

  @override
  Widget build(BuildContext context) {
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
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 150,
              maxHeight: 200,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, index) =>
                  AlbumListItemBig(item: list[index]),
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(width: 20),
            ),
          ),
        ],
      ),
    );
  }
}
