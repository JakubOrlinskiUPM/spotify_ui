import 'package:flutter/material.dart';
import 'package:spotify_ui/src/views/ui/author/author_view.dart';
import 'package:spotify_ui/src/views/ui/playlist/playlist_view.dart';

const String PLAYLIST_VIEW_ROUTE = "playlistView";
const String AUTHOR_VIEW_ROUTE = "authorView";

MaterialPageRoute? checkGeneralRoutes(route) {
  if (route.name.toString().startsWith(PLAYLIST_VIEW_ROUTE)) {
      String? id = route.name.split("/")[1];
      if (id != null) {
        return MaterialPageRoute(
          settings: route,
          builder: (context) {
            return PlaylistView(id: id);
          },
        );
      }
  } else if (route.name.toString().startsWith(AUTHOR_VIEW_ROUTE)) {
      int? id = int.tryParse(route.name.split("/")[1]);
      if (id != null) {
        return MaterialPageRoute(
          settings: route,
          builder: (context) {
            return AuthorView(id: id);
          },
        );
      }
  }
}
