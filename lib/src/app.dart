import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  final ThemeData themeDataDark = ThemeData(
    fontFamily: "Outfit",
    textTheme: TextTheme(
      caption: TextStyle(
        color: Colors.grey.shade400,
      ),
      bodyText2: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
    scaffoldBackgroundColor: Colors.black,
    canvasColor: Colors.black,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xffbb86fc),
      primaryVariant: Color(0xff3700B3),
      secondary: Color(0xfff5f5f5),
      secondaryVariant: Color(0xff929292),
      surface: Color(0xff343434),
      background: Colors.black,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        alignment: Alignment.centerLeft,
        shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
        overlayColor: MaterialStateProperty.all<Color>(Colors.grey.shade800),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify',
      darkTheme: themeDataDark,
      themeMode: ThemeMode.dark,
      home: Scaffold(
        body: FractionallySizedBox(
          alignment: Alignment.topCenter,
          heightFactor: 1.15,
          child: SafeArea(
            bottom: false,
            child: tabs[_currentIndex].navigator,
          ),
        ),
        bottomSheet: const PlaybackBottomSheet(),
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
