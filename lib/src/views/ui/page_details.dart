import 'package:flutter/material.dart';

abstract class PageDetails {
  late String pageName;
  late IconData pageIcon;
  late GlobalKey<NavigatorState> navigatorKey;
  late Navigator navigator;
}