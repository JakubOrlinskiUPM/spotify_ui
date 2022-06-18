import 'package:flutter/material.dart';
import 'package:spotify_ui/src/data/dummy_data/main.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Text("Search"),
        OutlinedButton(
          onPressed: syncDummySongs,
          child: Text("Sync songs"),
        ),
        OutlinedButton(
          onPressed: syncDummyPlaylists,
          child: Text("Sync playlists"),
        ),
        OutlinedButton(
          onPressed: syncDummyAlbums,
          child: Text("Sync albums"),
        ),
        OutlinedButton(
          onPressed: syncDummyAuthors,
          child: Text("Sync authors"),
        ),
      ],
    ));
  }
}
