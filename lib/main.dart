import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:spotify_ui/firebase_options.dart';

import 'package:spotify_ui/src/app.dart';
import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';
import 'package:spotify_ui/src/business_logic/blocs/player_bloc.dart';
import 'package:spotify_ui/src/business_logic/providers/playback_slider_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  AudioPlayer audioPlayer = AudioPlayer();
  DataBloc dataBloc = DataBloc();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PlayerBloc>(
          create: (context) => PlayerBloc(audioPlayer, dataBloc),
        ),
        BlocProvider<DataBloc>(
          create: (context) => dataBloc
        )
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<PlaybackSliderProvider>(
            create: (context) => PlaybackSliderProvider(audioPlayer),
          ),
        ],
        child: MaterialApp(
          title: 'Spotify',
          darkTheme: ThemeData(
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
                shadowColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                overlayColor:
                    MaterialStateProperty.all<Color>(Colors.grey.shade800),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            ),
          ),
          themeMode: ThemeMode.dark,
          home: App(),
        ),
      ),
    ),
  );
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // print(transition.hashCode);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // print(error);
    super.onError(bloc, error, stackTrace);
  }
}
