part of 'player_bloc.dart';

enum PlayerShuffle { on, off }
enum PlayerRepeat { off, playlist, song }
enum PlayerStatus { stopped, playing, paused }

class PlayerState extends Equatable {
  const PlayerState({
    required this.audioPlayer,
    this.status = PlayerStatus.stopped,
    this.repeat = PlayerRepeat.off,
    this.shuffle = PlayerShuffle.off,
    required this.queue,
    this.song,
    this.playlist,
    this.duration,
    this.position,
  });

  final AudioPlayer audioPlayer;

  final PlayerStatus status;
  final PlayerRepeat repeat;
  final PlayerShuffle shuffle;

  final ListQueue? queue;

  final Song? song;
  final Playlist? playlist;

  final Duration? position;
  final Duration? duration;

  PlayerState copyWith({
    AudioPlayer? audioPlayer,
    PlayerStatus? status,
    PlayerRepeat? repeat,
    PlayerShuffle? shuffle,
    ListQueue? queue,
    Song? song,
    Playlist? playlist,
    Duration? duration,
    Duration? position,
  }) {
    return PlayerState(
      audioPlayer: audioPlayer ?? this.audioPlayer,
      status: status ?? this.status,
      repeat: repeat ?? this.repeat,
      shuffle: shuffle ?? this.shuffle,
      queue: queue ?? this.queue,
      song: song ?? this.song,
      playlist: playlist ?? this.playlist,
      duration: duration ?? this.duration,
      position: position ?? this.position,
    );
  }

  static initialState() {
    return PlayerState(
        audioPlayer: AudioPlayer(),
        status: PlayerStatus.stopped,
        repeat: PlayerRepeat.off,
        shuffle: PlayerShuffle.off,
        duration: Duration(minutes: 1, seconds: 44),
        queue: ListQueue());
  }

  @override
  String toString() {
    return '''PlayerState { status: $status,  repeat: $repeat,  shuffle: $shuffle,  song: $song,  playlist: $playlist,  }''';
  }

  @override
  List<Object> get props => [status, repeat, shuffle];
}
