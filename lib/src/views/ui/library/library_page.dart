import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/views/ui/routing.dart';

enum SortBy { recentlyPlayed, recentlyAdded, alphabetical }

extension SortByStringExtension on SortBy {
  String get string {
    switch (this) {
      case SortBy.recentlyPlayed:
        return "Recently played";
      case SortBy.recentlyAdded:
        return "Recently added";
      case SortBy.alphabetical:
        return "Alphabetical";
      default:
        return "";
    }
  }
}

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  bool searchOpen = false;
  String searchText = "";
  SortBy sortBy = SortBy.recentlyPlayed;
  final List<PlaylistType> _chosenFilters = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red.shade300,
                    foregroundColor: Colors.white,
                    child: const Text('OD'),
                  ),
                  Text(
                    "Your library",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              searchOpen
                  ? SizedBox(
                      width: 100,
                      child: TextField(
                        onChanged: (text) {
                          setState(() {
                            searchText = text;
                          });
                        },
                      ),
                    )
                  : IconButton(
                      icon: const Icon(Icons.search_outlined),
                      onPressed: _toggleSearch,
                    ),
            ],
          ),
          Wrap(children: _buildChips(context)),
          TextButton(
            onPressed: _showSortBy,
            child: Row(
              children: [
                const Icon(Icons.swap_vert),
                Text(sortBy.string),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<DataBloc, DataState>(
              builder: (context, state) {
                List<Playlist> filtered = _getFilteredLibrary(state.library);
                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (BuildContext context, int index) {
                    Playlist pl = filtered[index];

                    return TextButton(
                      onPressed: () => _routeToPlaylist(pl),
                      child: ListTile(
                        leading: CachedNetworkImage(imageUrl: pl.coverUrl),
                        title: Text(pl.title),
                        subtitle: Text(
                            '''${pl.playlistType.string} ${utf8.decode([
                              0xE2,
                              0x80,
                              0xA2
                            ])} ${pl.authorString}'''),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Playlist> _getFilteredLibrary(List<Playlist> library) {
    List<Playlist> filtered = library;

    if (_chosenFilters.isNotEmpty) {
      filtered = filtered
          .where((pl) => _chosenFilters.contains(pl.playlistType))
          .toList();
    }
    if (searchText.isNotEmpty) {
      filtered = filtered
          .where((pl) =>
              pl.title.toLowerCase().contains(searchText.toLowerCase()) ||
              pl.authorString.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }

    filtered.sort((p1, p2) => p1.title.compareTo(p2.title));

    return filtered;
  }

  void _routeToPlaylist(Playlist pl) {
    Navigator.pushNamed(context, PLAYLIST_VIEW_ROUTE + "/${pl.id}");
  }

  void _toggleSearch() {
    setState(() {
      searchOpen = !searchOpen;
    });
  }

  List<Widget> _buildChips(BuildContext context) {
    return PlaylistType.values.map((type) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          selectedColor: Colors.green,
          label: Text(type.string),
          selected: _chosenFilters.contains(type),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _chosenFilters.add(type);
              } else {
                _chosenFilters.removeWhere((PlaylistType pt) {
                  return pt == type;
                });
              }
            });
          },
        ),
      );
    }).toList();
  }

  void _showSortBy() async {
    SortBy? newSort = await showModalBottomSheet<SortBy>(
      backgroundColor: Colors.grey.shade800,
      useRootNavigator: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext ctx) {
        return Column(children: SortBy.values.map((sort) =>
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(
                    ctx,
                    sort,
                  );
                },
                child: Text(sort.string),
              ),
            ),
          ).toList());
      },
    );
    if (newSort != null) {
      setState(() {
        sortBy = newSort;
      });
    }
  }
}
