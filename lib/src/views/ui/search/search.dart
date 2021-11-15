import 'package:flutter/material.dart';
import 'package:spotify_ui/src/views/ui/Search/Search_page.dart';

import '../page_details.dart';

class Search extends PageDetails {
  String pageName = "Search";
  IconData pageIcon = Icons.search;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late Navigator navigator;

  Search() {
    navigator = Navigator(
      key: navigatorKey,
      onGenerateRoute: (route) => MaterialPageRoute(
        settings: route,
        builder: (context) => const SearchPage(),
      ),
    );
  }
}