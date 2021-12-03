import 'package:flutter/material.dart';
import 'package:spotify_ui/src/views/ui/playlist/playlist_view.dart';

const String PLAYLIST_VIEW_ROUTE = "playlistView";

MaterialPageRoute? checkGeneralRoutes(route) {
  switch (route.name) {
    case PLAYLIST_VIEW_ROUTE:
      return MaterialPageRoute(
        settings: route,
        builder: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          return PlaylistView(
            playlist: args != null ? (args as Map)['playlist'] : null,
          );
        },
      );
  }
}
