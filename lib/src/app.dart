import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/blocs/player_bloc.dart';
import 'package:spotify_ui/src/sign_in_guard.dart';

import 'package:spotify_ui/src/views/ui/home/home.dart';
import 'package:spotify_ui/src/views/ui/library/library.dart';
import 'package:spotify_ui/src/views/ui/page_details.dart';
import 'package:spotify_ui/src/views/ui/playback/playback_bottom_sheet.dart';
import 'package:spotify_ui/src/views/ui/search/search.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;

  final List<PageDetails> tabs = [
    Home(),
    Search(),
    Library(),
  ];

  @override
  void dispose() {
    context.read<PlayerBloc>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await tabs[_currentIndex].navigatorKey.currentState!.maybePop(),
      child: Scaffold(
        body: SignInGuard(child: tabs[_currentIndex].navigator),
        bottomSheet: PlaybackBottomSheet(
            currentNavigator: tabs[_currentIndex].navigatorKey),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withAlpha(150), Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.7],
              tileMode: TileMode.clamp,
            ),
          ),
          child: BottomNavigationBar(
              iconSize: 30,
              backgroundColor: Colors.transparent,
              currentIndex: _currentIndex,
              onTap: (val) => _onTap(val, context),
              items: tabs
                  .map(
                    (tab) => BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                        child: Icon(tab.pageIcon),
                      ),
                      label: tab.pageName,
                    ),
                  )
                  .toList()),
        ),
      ),
    );
  }

  void _onTap(int val, BuildContext context) {
    if (_currentIndex == val) {
      tabs[_currentIndex]
          .navigatorKey
          .currentState
          ?.popUntil((route) => route.isFirst);
    } else {
      if (mounted) {
        setState(() {
          _currentIndex = val;
        });
      }
    }
  }
}
