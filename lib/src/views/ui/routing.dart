import 'package:flutter/material.dart';
import 'package:spotify_ui/src/views/ui/author/author_view.dart';
import 'package:spotify_ui/src/views/ui/playlist/playlist_view.dart';
import 'package:spotify_ui/src/views/ui/settings/settings_view.dart';

const String PLAYLIST_VIEW_ROUTE = "playlistView";
const String AUTHOR_VIEW_ROUTE = "authorView";
const String SETTINGS_ROUTE = "settingsView";


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
    String? id = route.name.split("/")[1];
    if (id != null) {
      return MaterialPageRoute(
        settings: route,
        builder: (context) {
          return AuthorView(id: id);
        },
      );
    }
  } else if (route.name.toString().startsWith(SETTINGS_ROUTE)) {
    return MaterialPageRoute(
      settings: route,
      builder: (context) {
        return SettingsView();
      },
    );
  }
}


extension NavigatorStateExtension on NavigatorState {

  void pushNamedIfNotCurrent( String routeName, {Object? arguments} ) {
    if (!isCurrent(routeName)) {
      pushNamed( routeName, arguments: arguments );
    }
  }

  bool isCurrent( String routeName ) {
    bool isCurrent = false;
    popUntil( (route) {
      if (route.settings.name == routeName) {
        isCurrent = true;
      }
      return true;
    } );
    return isCurrent;
  }

}