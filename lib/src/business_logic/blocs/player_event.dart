part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PlayerSetSongEvent extends PlayerEvent {
  final Song song;
  final Playlist? playlist;

  PlayerSetSongEvent({
    required this.song,
    this.playlist
  });
}

class PlayerPositionEvent extends PlayerEvent {
  final Duration position;

  PlayerPositionEvent({required this.position});
}

class PlayerStartedEvent extends PlayerEvent {}
class PlayerStoppedEvent extends PlayerEvent {}
class PlayerForwardEvent extends PlayerEvent {}
class PlayerBackwardEvent extends PlayerEvent {}
class PlayerShuffleEvent extends PlayerEvent {}
class PlayerRepeatEvent extends PlayerEvent {}