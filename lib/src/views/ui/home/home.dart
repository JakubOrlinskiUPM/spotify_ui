import 'package:flutter/material.dart';
import 'package:spotify_ui/src/views/ui/routing.dart';

import '../page_details.dart';
import 'home_page.dart';

class Home extends PageDetails {
  String pageName = "Home";
  IconData pageIcon = Icons.home_filled;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late Navigator navigator;

  Home() {
    navigator = Navigator(
      key: navigatorKey,
      onGenerateRoute: (route) {
        MaterialPageRoute? r = checkGeneralRoutes(route);
        if (r != null) {
          return r;
        }

        switch(route.name) {
          default:
            return MaterialPageRoute(
              settings: route,
              builder: (context) => const HomePage(),
            );
        }
      }
    );
  }
}