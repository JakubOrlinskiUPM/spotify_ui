import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';
import 'package:spotify_ui/src/views/ui/components/custom_future_builder.dart';
import 'package:spotify_ui/src/views/ui/search/search_author_item.dart';
import 'package:spotify_ui/src/views/ui/search/search_playlist_item.dart';
import 'package:spotify_ui/src/views/ui/search/search_song_item.dart';

import 'package:spotify_ui/src/views/ui/utils.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({Key? key, required this.query}) : super(key: key);

  final String query;

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  String selectedCategory = "";

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<Map<String, List<String>>>(
      future: BlocProvider.of<DataBloc>(context).search(widget.query),
      child: (Map<String, List<String>> results) {
        List<Map<String, String>> items = getListFromResults(results);
        List chips =
        results.keys.where((key) => results[key]!.isNotEmpty).toList();
        String selected = selectedCategory != "" ? selectedCategory : chips[0];

        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: chips.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return FilterChip(
                        selected: selected == chips[index],
                        label: Text(chips[index].toString().capitalize()),
                        onSelected: (bool selected) {
                          if (!selected && selected == chips[index]) {
                            setState(() {
                              selectedCategory = "";
                            });
                          }
                          if (selected) {
                            setState(() {
                              selectedCategory = chips[index];
                            });
                          }
                        },
                      );
                    },
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    String? type = items[index]['type'];
                    String? id = items[index]['item'];
                    if (id == null) {
                      return Text("Failed..");
                    }
                    switch (type) {
                      case "playlists":
                        return SearchPlaylistItem(
                          id: id,
                        );
                      case "authors":
                        return SearchAuthorItem(
                          id: id,
                        );
                      case "songs":
                        return SearchSongItem(
                          id: id,
                        );
                      default:
                        return Container(
                          child: Text("Nothing"),
                        );
                    }
                  },
                ),
              ],
          ),
        );
      },
    );
  }

  List<Map<String, String>> getListFromResults(
      Map<String, List<String>> results) {
    List<Map<String, String>> res = [];
    for (String type in results.keys) {
      if (results.containsKey(type) && results[type] != null) {
        for (String item in results[type]!) {
          res.add({"item": item, "type": type});
        }
      }
    }
    return res;
  }
}
