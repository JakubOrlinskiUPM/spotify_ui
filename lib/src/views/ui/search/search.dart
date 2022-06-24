import 'package:flutter/material.dart';
import 'package:spotify_ui/src/views/ui/Search/Search_page.dart';
import 'package:spotify_ui/src/views/ui/routing.dart';
import 'package:spotify_ui/src/views/ui/search/search_view.dart';

import '../page_details.dart';

const String SEARCH_VIEW = "searchView";

class Search extends PageDetails {
  String pageName = "Search";
  IconData pageIcon = Icons.search;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late Navigator navigator;
  Map routeMap = {SEARCH_VIEW: SearchView()};

  Search() {
    navigator = Navigator(
      key: navigatorKey,
      onGenerateRoute: (route) {
        if (routeMap.containsKey(route.name)) {
          return PageRouteBuilder(
            pageBuilder: (c, a1, a2) => routeMap[route.name],
            transitionsBuilder: (c, anim, a2, child) {
              const begin = 0.0;
              const end = 1.0;
              const curve = Curves.easeIn;
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return FadeTransition(opacity: anim.drive(tween), child: child);
            },
            transitionDuration: Duration(milliseconds: 300),
          );
        }

        MaterialPageRoute? r = checkGeneralRoutes(route);
        if (r != null) {
          return r;
        }

        switch (route.name) {
          default:
            return MaterialPageRoute(
              settings: route,
              builder: (context) => const SearchPage(),
            );
        }
      },
      observers: [
        HeroController(),
      ],
    );
  }
}
