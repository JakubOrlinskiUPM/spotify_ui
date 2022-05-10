import 'package:flutter/material.dart';
import 'package:spotify_ui/src/views/ui/playlist/playlist_view.dart';

const String PLAYLIST_VIEW_ROUTE = "playlistView";

MaterialPageRoute? checkGeneralRoutes(route) {
  if (route.name.toString().startsWith(PLAYLIST_VIEW_ROUTE)) {
      print(route.name.split("/")[1]);
      int? id = int.tryParse(route.name.split("/")[1]);
      if (id != null) {
        return MaterialPageRoute(
          settings: route,
          builder: (context) {
            return PlaylistView(id: id);
          },
        );
      }
  }
}
