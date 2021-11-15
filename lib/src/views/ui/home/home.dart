import 'package:flutter/material.dart';

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
      onGenerateRoute: (route) => MaterialPageRoute(
        settings: route,
        builder: (context) => const HomePage(),
      ),
    );
  }
}