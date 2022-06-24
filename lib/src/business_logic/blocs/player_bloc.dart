import 'dart:collection';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/blocs/data_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/playlist_type.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:spotify_ui/src/business_logic/utils/custom_audio_cache.dart';

part 'player_event.dart';

part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  AudioPlayer audioPlayer;
  late CustomAudioCache audioCache;
  DataBloc dataBloc;

  PlayerBloc(this.audioPlayer, this.dataBloc)
      : super(PlayerState.initialState()) {
    on<PlayerSetSongEvent>(_onPlayerSetSong);
    on<PlayerStartedEvent>(_onPlayerStarted);
    on<PlayerStoppedEvent>(_onPlayerStopped);
    on<PlayerForwardEvent>(_onPlayerForward);
    on<PlayerBackwardEvent>(_onPlayerBackward);
    on<PlayerPositionEvent>(_onPlayerPosition);

    audioCache = CustomAudioCache();

    audioPlayer.onPlayerComplete.listen((event) {
      Song s = nextSong(user: false);
      add(PlayerSetSongEvent(
        song: s,
        play: state.playlist!.songIds.indexOf(s.id) != 0,
      ));
    });
  }

  Song nextSong({required bool user}) {
    int newIndex = state.songIndex + 1;
    if (state.repeat == PlayerRepeat.song && !user) {
      newIndex = state.songIndex;
    }

    if (state.repeat == PlayerRepeat.playlist ||
        state.repeat == PlayerRepeat.off ||
        user) {
      newIndex = newIndex % state.playlist!.songs.length;
    }
    return state.playlist!.songs[newIndex];
  }

  Song previousSong() {
    int newIndex =
        (state.songIndex - 1).clamp(0, state.playlist!.songIds.length);
    return state.playlist!.songs[newIndex];
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }

  Future<void> _onPlayerSetSong(
      PlayerSetSongEvent event, Emitter<PlayerState> emit) async {
    Playlist playlist =
        event.playlist != null ? event.playlist! : state.playlist!;

    int currentIndex = playlist.songIds.indexOf(event.song.id);
    emit(state.copyWith(
      song: event.song,
      playlist: playlist,
      songIndex: currentIndex,
    ));

    audioCache.setSongHandler(currentIndex, playlist);

    await audioPlayer.stop();
    if (event.play) {
      audioPlayer.play(audioCache.getSongSource(event.song.storageUrl));
    }

    if (event.playlist != null &&
        playlist.playlistType != PlaylistType.artistPlaylist) {
      List<Song> songs = await dataBloc.getPlaylistSongs(event.playlist!);
      event.playlist!.songs = songs;
      event.playlist!.sortSongs();
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
    Song s = nextSong(user: false);
    add(PlayerSetSongEvent(song: s, play: true));
  }

  void _onPlayerBackward(
      PlayerBackwardEvent event, Emitter<PlayerState> emit) async {
    Duration? pos = await audioPlayer.getCurrentPosition();
    if (pos != null && pos.inMilliseconds < 3000) {
      audioPlayer.seek(const Duration(milliseconds: 0));
    } else {
      Song s = previousSong();
      add(PlayerSetSongEvent(song: s, play: true));
    }
  }
}
