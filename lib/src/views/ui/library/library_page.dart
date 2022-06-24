import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/user_playlist.dart';
import 'package:spotify_ui/src/views/ui/library/library_playlist_item.dart';
import 'package:spotify_ui/src/views/ui/components/bottom_sheet_dismiss_bar.dart';
import 'package:spotify_ui/src/business_logic/models/playlist_type.dart';
import 'package:spotify_ui/src/views/ui/routing.dart';

enum SortBy { recentlyPlayed, recentlyAdded, alphabetical, creator }

extension SortByStringExtension on SortBy {
  String get string {
    switch (this) {
      case SortBy.recentlyPlayed:
        return "Recently played";
      case SortBy.recentlyAdded:
        return "Recently added";
      case SortBy.alphabetical:
        return "Alphabetical";
      case SortBy.creator:
        return "Creator";
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
  SortBy sortBy = SortBy.recentlyPlayed;
  final List<PlaylistType> _chosenFilters = [];

  @override
  void initState() {
    BlocProvider.of<DataBloc>(context).add(DataFetchLibrary());
    super.initState();
  }

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
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SETTINGS_ROUTE);
                },
                icon: Icon(
                  Icons.settings,
                ),
              )
            ],
          ),
          _buildChips(context),
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
                List<UserPlaylist> filtered = _getFilteredLibrary(state.library);
                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (BuildContext context, int index) {
                    return LibraryPlaylistItem(item: filtered[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<UserPlaylist> _getFilteredLibrary(List<UserPlaylist> library) {
    List<UserPlaylist> filtered = library;

    if (_chosenFilters.isNotEmpty) {
      filtered = filtered
          .where((pl) => _chosenFilters.contains(pl.type))
          .toList();
    }

    filtered.sort((p1, p2) => p1.name.compareTo(p2.name));

    return filtered;
  }

  Widget _buildChips(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: PlaylistType.values.map((type) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: FilterChip(
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
        }).toList(),
      ),
    );
  }

  void _showSortBy() async {
    SortBy? newSort = await showModalBottomSheet<SortBy>(
      backgroundColor: Colors.grey.shade800,
      useRootNavigator: true,
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BottomSheetDismissBar(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sort by",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    for (var sort in SortBy.values) ...[
                      TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                        onPressed: () {
                          Navigator.pop(
                            ctx,
                            sort,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              sort.string,
                              style: TextStyle(
                                  color: sort == sortBy
                                      ? Colors.green
                                      : Colors.white),
                            ),
                            if (sort == sortBy) ...[
                              Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                            ]
                          ],
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            )
          ],
        );
      },
    );
    if (newSort != null) {
      setState(() {
        sortBy = newSort;
      });
    }
  }
}
