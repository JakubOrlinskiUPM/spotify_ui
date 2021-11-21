import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:spotify_ui/src/app.dart';
import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';
import 'package:spotify_ui/src/business_logic/blocs/player_bloc.dart';
import 'package:spotify_ui/src/business_logic/providers/playback_slider_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();
  AudioPlayer audioPlayer = AudioPlayer();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PlayerBloc>(
          create: (context) => PlayerBloc(audioPlayer),
        ),
        BlocProvider<DataBloc>(
          create: (context) => DataBloc()
            ..add(DataFetchRecentlyPlayed())
            ..add(DataFetch()),
        )
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<PlaybackSliderProvider>(
            create: (context) => PlaybackSliderProvider(audioPlayer),
          ),
        ],
        child: const App(),
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
