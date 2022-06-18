import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:audioplayers/audioplayers.dart';

part 'player_event.dart';

part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  AudioPlayer audioPlayer;
  DataBloc dataBloc;

  PlayerBloc(this.audioPlayer, this.dataBloc)
      : super(PlayerState.initialState()) {
    on<PlayerSetSongEvent>(_onPlayerSetSong);
    on<PlayerStartedEvent>(_onPlayerStarted);
    on<PlayerStoppedEvent>(_onPlayerStopped);
    on<PlayerForwardEvent>(_onPlayerForward);
    on<PlayerBackwardEvent>(_onPlayerBackward);
    on<PlayerPositionEvent>(_onPlayerPosition);

    audioPlayer.onPlayerCompletion.listen((event) {
      Song? s = state.playlist?.songs[state.songIndex + 1];
      if (s != null) {
        add(PlayerSetSongEvent(song: s));
      }
    });
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }

  Future<void> _onPlayerSetSong(
      PlayerSetSongEvent event, Emitter<PlayerState> emit) async {
    emit(state.copyWith(
      song: event.song,
      playlist: event.playlist,
      songIndex: state.playlist?.songs.indexOf(event.song) ?? 0,
    ));
    audioPlayer.play(event.song.storageUrl);

    if (event.playlist != null && event.playlist!.songs.isEmpty) {
      List<Song> songs = await dataBloc.getPlaylistSongs(event.playlist!);
      event.playlist!.songs = songs;
      emit(state.copyWith(
        playlist: event.playlist,
      ));
    }
    add(PlayerStartedEvent());
  }

  void _onPlayerPosition(PlayerPositionEvent event, Emitter<PlayerState> emit) {
    emit(state.copyWith(
      position: event.position,
    ));
  }

  Future<void> _onPlayerStarted(
      PlayerStartedEvent event, Emitter<PlayerState> emit) async {
    if (state.song != null) {
      audioPlayer.resume();
      emit(state.copyWith(
        status: PlayerStatus.playing,
      ));
    }
  }

  Future<void> _onPlayerStopped(
      PlayerStoppedEvent event, Emitter<PlayerState> emit) async {
    await audioPlayer.pause();

    emit(state.copyWith(
      status: PlayerStatus.stopped,
    ));
  }

  void _onPlayerForward(PlayerForwardEvent event, Emitter<PlayerState> emit) {
    if (state.song != null) {
      audioPlayer.play(state.song!.storageUrl);

      emit(state.copyWith(
        status: PlayerStatus.playing,
      ));
    }
  }

  void _onPlayerBackward(PlayerBackwardEvent event, Emitter<PlayerState> emit) {
    if (state.song != null) {
      audioPlayer.play(state.song!.storageUrl);

      emit(state.copyWith(
        status: PlayerStatus.playing,
      ));
    }
  }

  void _listenToPlayerState(event) {
    print("_listenToPlayerState $event");
  }

  void _listenToDuration(event) {
    print("_listenToDuration $event");
  }
}
