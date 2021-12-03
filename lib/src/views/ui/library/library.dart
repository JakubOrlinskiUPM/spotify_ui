import 'package:flutter/material.dart';
import 'package:spotify_ui/src/views/ui/library/library_page.dart';
import 'package:spotify_ui/src/views/ui/routing.dart';

import '../page_details.dart';

class Library extends PageDetails {
  String pageName = "Library";
  IconData pageIcon = Icons.library_music;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late Navigator navigator;

  Library() {
    navigator = Navigator(
      key: navigatorKey,
      onGenerateRoute: (route) {
        MaterialPageRoute? r = checkGeneralRoutes(route);
        if (r != null) {
          return r;
        }

        switch (route.name) {
          default:
            return MaterialPageRoute(
              settings: route,
              builder: (context) => const LibraryPage(),
            );
        }
      },
      observers: [
        HeroController(),
      ],
    );
  }
}
