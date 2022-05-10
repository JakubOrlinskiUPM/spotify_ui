import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/author.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:spotify_ui/src/business_logic/models/user.dart';

const List<Author> AUTHOR_LIST = [
  Author(name: 'John Coltrane', imageUrl: '', id: 1),
  Author(name: 'Engelwood', imageUrl: '', id: 2),
  Author(name: 'NZCA Lines', imageUrl: '', id: 3),
  Author(name: 'The Briarwoods', imageUrl: '', id: 4),
  Author(name: 'Prinzhorn High Drama Society', imageUrl: '', id: 5),
];

const List<User> USER_LIST = [
  User(id: 1, name: "Jake"),
];

List<Song> SONG_LIST = [
  Song(
    album: Playlist(
      playlistType: PlaylistType.album,
      coverUrl:
          'https://i1.wp.com/theseconddisc.com/wp-content/uploads/John-Coltrane-Another-Side-of-John-Coltrane.jpg?fit=1500%2C1472&ssl=1',
      title: 'An amazing album',
      id: 1,
      authors: [AUTHOR_LIST[0]],
    ),
    id: 1,
    title: 'A great song!',
    authors: [Author(name: 'John Coltrane', imageUrl: '', id: 1)],
    storageUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutterapp-7eda9.appspot.com/o/songs%2FMoose%20Dowa-Alleycat%20Jazz.mp3?alt=media&token=ceab75c2-e9a3-4f02-9fcc-1fc4d1488e67',
  ),
  Song(
    album: Playlist(
      playlistType: PlaylistType.album,
      coverUrl: 'https://f4.bcbits.com/img/a2321763329_10.jpg',
      title: 'An amazing album',
      id: 2,
      authors: [AUTHOR_LIST[1]],
    ),
    id: 2,
    title: 'Book',
    authors: [AUTHOR_LIST[1]],
    storageUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutterapp-7eda9.appspot.com/o/songs%2FEngelwood-One%20Step%20Ahead.mp3?alt=media&token=d530ce34-5010-4127-9d07-154bf80a3049',
  ),
  Song(
    album: Playlist(
      playlistType: PlaylistType.album,
      coverUrl:
          'https://images-na.ssl-images-amazon.com/images/I/71fij9klnNL._SY355_.jpg',
      title: 'Its dope!',
      id: 3,
      authors: [AUTHOR_LIST[1]],
    ),
    id: 3,
    title: 'Opening Night',
    authors: [AUTHOR_LIST[1]],
    storageUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutterapp-7eda9.appspot.com/o/songs%2FNZCA%20LINES-Opening%20Night.mp3?alt=media&token=2ecdef2d-adff-496a-97b1-f695b30be405',
  ),
  Song(
    album: Playlist(
      playlistType: PlaylistType.album,
      coverUrl:
          'https://images-na.ssl-images-amazon.com/images/I/71fij9klnNL._SY355_.jpg',
      title: 'The album of goths',
      id: 5,
      authors: [AUTHOR_LIST[3]],
    ),
    id: 4,
    title: 'Vampire song',
    authors: [AUTHOR_LIST[3]],
    storageUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutterapp-7eda9.appspot.com/o/songs%2FNZCA%20LINES-Opening%20Night.mp3?alt=media&token=2ecdef2d-adff-496a-97b1-f695b30be405',
  ),
  Song(
    album: Playlist(
      playlistType: PlaylistType.album,
      coverUrl:
          'https://images-na.ssl-images-amazon.com/images/I/71fij9klnNL._SY355_.jpg',
      title: 'The album of goths',
      id: 5,
      authors: [AUTHOR_LIST[3]],
    ),
    id: 5,
    title: 'Ode to the void in which we live everyday',
    authors: [AUTHOR_LIST[3]],
    storageUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutterapp-7eda9.appspot.com/o/songs%2FNZCA%20LINES-Opening%20Night.mp3?alt=media&token=2ecdef2d-adff-496a-97b1-f695b30be405',
  ),
  Song(
    album: Playlist(
      playlistType: PlaylistType.album,
      coverUrl:
          'https://images-na.ssl-images-amazon.com/images/I/71fij9klnNL._SY355_.jpg',
      title: 'The album of goths',
      id: 5,
      authors: [AUTHOR_LIST[3]],
    ),
    id: 6,
    title: 'A short song',
    authors: [AUTHOR_LIST[3]],
    storageUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutterapp-7eda9.appspot.com/o/songs%2FNZCA%20LINES-Opening%20Night.mp3?alt=media&token=2ecdef2d-adff-496a-97b1-f695b30be405',
  ),
];

List<Playlist> ALBUM_LIST = [
  Playlist(
    playlistType: PlaylistType.album,
    coverUrl:
    'https://i1.wp.com/theseconddisc.com/wp-content/uploads/John-Coltrane-Another-Side-of-John-Coltrane.jpg?fit=1500%2C1472&ssl=1',
    title: 'An amazing album',
    id: 1,
    authors: [AUTHOR_LIST[0]],
    songs: [SONG_LIST[0]],
  ),
  Playlist(
    playlistType: PlaylistType.album,
    coverUrl: 'https://f4.bcbits.com/img/a2321763329_10.jpg',
    title: 'An amazing album',
    id: 2,
    authors: [AUTHOR_LIST[1]],
    songs: [SONG_LIST[1]],
  ),
  Playlist(
    playlistType: PlaylistType.album,
    coverUrl:
    'https://images-na.ssl-images-amazon.com/images/I/71fij9klnNL._SY355_.jpg',
    title: 'Its dope!',
    id: 3,
    authors: [AUTHOR_LIST[2]],
    songs: [SONG_LIST[2]],
  ),
  Playlist(
    playlistType: PlaylistType.album,
    coverUrl:
    'https://images-na.ssl-images-amazon.com/images/I/71fij9klnNL._SY355_.jpg',
    title: 'The album of goths',
    id: 4,
    authors: [AUTHOR_LIST[3]],
  ),
];

List<Playlist> PLAYLIST_LIST = [
  Playlist(
    playlistType: PlaylistType.album,
    title: 'Cool Playlist',
    coverUrl:
        'https://images-na.ssl-images-amazon.com/images/I/71fij9klnNL._SY355_.jpg',
    id: 5,
    authors: [AUTHOR_LIST[2]],
    songs: SONG_LIST,
    colorHex: 0xff9c3b45,
  ),
  Playlist(
    playlistType: PlaylistType.userPlaylist,
    title: 'My Playlist',
    coverUrl: 'https://f4.bcbits.com/img/a2321763329_10.jpg',
    id: 6,
    userAuthors: [USER_LIST[0]],
    songs: SONG_LIST,
    colorHex: 0xff03347b,
  ),
];

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataState.initialState()) {
    on<DataFetchRecentlyPlayed>(_onFetchRecentlyPlayed);
  }

  _onFetchRecentlyPlayed(
      DataFetchRecentlyPlayed event, Emitter<DataState> emit) {
    emit(state.copyWith(
      recentlyPlayed: PLAYLIST_LIST,
      library: PLAYLIST_LIST,
    ));
  }

  Playlist? getPlaylistById(int id) {
    Playlist? res = PLAYLIST_LIST.firstWhere((playlist) => playlist.id == id, orElse: () => ALBUM_LIST.firstWhere((playlist) => playlist.id == id));
    return res;
  }
}

abstract class DataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DataFetchRecentlyPlayed extends DataEvent {}

class DataFetch extends DataEvent {}

class DataState extends Equatable {
  final List<Playlist> recentlyPlayed;
  final List<Playlist> library;

  const DataState({
    this.recentlyPlayed = const [],
    this.library = const [],
  });

  DataState copyWith({
    List<Playlist>? recentlyPlayed,
    List<Playlist>? library,
  }) {
    return DataState(
      recentlyPlayed: recentlyPlayed ?? this.recentlyPlayed,
      library: library ?? this.library,
    );
  }

  static initialState() {
    return const DataState(
      recentlyPlayed: [],
      library: [],
    );
  }

  @override
  String toString() {
    return '''DataState { data: $recentlyPlayed }''';
  }

  @override
  List<Object?> get props => [];
}
