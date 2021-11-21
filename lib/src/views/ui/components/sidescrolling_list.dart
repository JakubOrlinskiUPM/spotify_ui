import 'package:flutter/material.dart';

import 'package:spotify_ui/src/views/ui/components/sidescrolling_list_item.dart';

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
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, index) =>
                  SidescrollingListItem(item: list[index]),
              separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 20),
            ),
          ),
        ],
      ),
    );
  }
}
