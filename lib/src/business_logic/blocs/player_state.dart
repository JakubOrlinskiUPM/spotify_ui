part of 'player_bloc.dart';

enum PlayerShuffle { on, off }
enum PlayerRepeat { off, playlist, song }
enum PlayerStatus { stopped, playing, paused }

const Song s1 = Song(
  album: Album(
    coverUrl: 'https://i1.wp.com/theseconddisc.com/wp-content/uploads/John-Coltrane-Another-Side-of-John-Coltrane.jpg?fit=1500%2C1472&ssl=1',
    title: 'An amazing album',
    id: 1,
    authors: [Author(name: 'John Coltrane', imageUrl: '', id: 1)],
  ),
  id: 1,
  title: 'A great song!',
  authors: [Author(name: 'John Coltrane', imageUrl: '', id: 1)],
  storageUrl:
  'https://firebasestorage.googleapis.com/v0/b/flutterapp-7eda9.appspot.com/o/songs%2FMoose%20Dowa-Alleycat%20Jazz.mp3?alt=media&token=ceab75c2-e9a3-4f02-9fcc-1fc4d1488e67',
);
const Song s2 = Song(
  album: Album(
    coverUrl: 'https://f4.bcbits.com/img/a2321763329_10.jpg',
    title: 'An amazing album',
    id: 2,
    authors: [Author(name: 'Engelwood', imageUrl: '', id: 2)],
  ),
  id: 2,
  title: 'Book',
  authors: [Author(name: 'Engelwood', imageUrl: '', id: 2)],
  storageUrl:
  'https://firebasestorage.googleapis.com/v0/b/flutterapp-7eda9.appspot.com/o/songs%2FEngelwood-One%20Step%20Ahead.mp3?alt=media&token=d530ce34-5010-4127-9d07-154bf80a3049',
);
const Song s3 = Song(
  album: Album(
    coverUrl: 'https://images-na.ssl-images-amazon.com/images/I/71fij9klnNL._SY355_.jpg',
    title: 'Its dope!',
    id: 3,
    authors: [Author(name: 'Engelwood', imageUrl: '', id: 3)],
  ),
  id: 3,
  title: 'Opening Night',
  authors: [Author(name: 'NZCA Lines', imageUrl: '', id: 3)],
  storageUrl:
  'https://firebasestorage.googleapis.com/v0/b/flutterapp-7eda9.appspot.com/o/songs%2FNZCA%20LINES-Opening%20Night.mp3?alt=media&token=2ecdef2d-adff-496a-97b1-f695b30be405',
);

const Playlist p = Playlist(title: '', coverUrl: '', id: 1, authors: [], songs: [s1, s2, s3]);


class PlayerState extends Equatable {
  const PlayerState({
    this.status = PlayerStatus.stopped,
    this.repeat = PlayerRepeat.off,
    this.shuffle = PlayerShuffle.off,
    required this.queue,
    this.song = s1,
    this.playlist = p,
    this.duration,
    this.position,
    this.songIndex = 0,
  });

  final PlayerStatus status;
  final PlayerRepeat repeat;
  final PlayerShuffle shuffle;

  final ListQueue? queue;

  final Song? song;
  final Playlist? playlist;

  final Duration? position;
  final Duration? duration;

  final int songIndex;

  PlayerState copyWith({
    PlayerStatus? status,
    PlayerRepeat? repeat,
    PlayerShuffle? shuffle,
    ListQueue? queue,
    Song? song,
    Playlist? playlist,
    Duration? duration,
    Duration? position,
    int? songIndex,
  }) {
    return PlayerState(
      status: status ?? this.status,
      repeat: repeat ?? this.repeat,
      shuffle: shuffle ?? this.shuffle,
      queue: queue ?? this.queue,
      song: song ?? this.song,
      playlist: playlist ?? this.playlist,
      duration: duration ?? this.duration,
      position: position ?? this.position,
      songIndex: songIndex ?? this.songIndex,
    );
  }

  static initialState() {
    return PlayerState(
        status: PlayerStatus.stopped,
        repeat: PlayerRepeat.off,
        shuffle: PlayerShuffle.off,
        duration: const Duration(minutes: 1, seconds: 44),
        queue: ListQueue(),
        songIndex: 0);
  }

  @override
  String toString() {
    return '''PlayerState { status: $status,  repeat: $repeat,  shuffle: $shuffle,  song: $song,  playlist: $playlist,  }''';
  }

  @override
  List<Object?> get props => [status, repeat, shuffle, song];
}
