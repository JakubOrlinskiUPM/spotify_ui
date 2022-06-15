import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/author.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:spotify_ui/src/business_logic/models/user.dart';

const List<Author> AUTHOR_LIST = [
  Author(
      id: 1,
      name: 'John Coltrane',
      imageUrl:
          'https://i.scdn.co/image/ab6761610000e5eb73c7f7505c1af82929ec41df'),
  Author(
      id: 2,
      name: 'Engelwood',
      imageUrl:
          'https://edmidentity.com/wp-content/uploads/2021/02/cGrknm_Q-696x464.jpeg'),
  Author(
      id: 3,
      name: 'NZCA Lines',
      imageUrl:
          'https://i.guim.co.uk/img/media/9f68d75cee3f21b7ffca69ccfdb8051804c0b532/163_0_3458_2076/master/3458.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=24cde21289c5935f24efd6abe238bd83'),
  Author(
      id: 4,
      name: 'The Briarwoods',
      imageUrl:
          'https://media.distractify.com/brand-img/QQZqP1Fw1/0x0/delilah-briarwood-vox-machina-1643385858271.jpg'),
  Author(
      id: 5,
      name: 'Prinzhorn Dance School',
      imageUrl:
          'https://www.dachstock.ch/wp-content/uploads/2016/07/Prinzhorn-Dance-School-e1469018148724.jpg'),
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
    listenCount: 214214,
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
    listenCount: 32551,
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
    listenCount: 162321,
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
    listenCount: 985223,
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
    listenCount: 1285120,
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
    listenCount: 1241211,
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
  Playlist(
    playlistType: PlaylistType.userPlaylist,
    title: 'Another playlist',
    coverUrl:
        'https://media.gq.com/photos/5ae3925b3fb87856d8a5cdf6/3:2/w_1848,h_1232,c_limit/Road-Trip-Playlist-GQ-April-2018-042718-3x2.png',
    id: 7,
    userAuthors: [USER_LIST[0]],
    songs: SONG_LIST,
    colorHex: 0xff69037b,
  ),
  Playlist(
    playlistType: PlaylistType.userPlaylist,
    title: 'My favorties',
    coverUrl:
        'https://i1.sndcdn.com/avatars-wpOz0Tqdl3eoO4WM-O3P1Qw-t500x500.jpg',
    id: 8,
    userAuthors: [USER_LIST[0]],
    songs: SONG_LIST,
    colorHex: 0xff69037b,
  ),
  Playlist(
    playlistType: PlaylistType.userPlaylist,
    title: '12/05/2021',
    coverUrl: 'https://img.myloview.es/posters/playlist-700-241919855.jpg',
    id: 9,
    userAuthors: [USER_LIST[0]],
    songs: SONG_LIST,
    colorHex: 0xff69037b,
  ),
  Playlist(
    playlistType: PlaylistType.userPlaylist,
    title: 'Top 50',
    coverUrl:
        'https://charts-images.scdn.co/assets/locale_en/regional/daily/region_global_large.jpg',
    id: 10,
    userAuthors: [USER_LIST[0]],
    songs: SONG_LIST,
    colorHex: 0xff69037b,
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
      recommended: ALBUM_LIST,
    ));
  }

  Future<Playlist?> getPlaylistById(String id) {
    return state.playlistsRef.doc(id).get().then((DocumentSnapshot doc) {
      final json = doc.data() as Map<String, dynamic>;
      return Playlist.fromJson(json);
    });
  }

  Future<List<Song>> getPlaylistSongs(String id) {
    return state.playlistsRef
        .doc(id)
        .collection("songs")
        .get()
        .then((QuerySnapshot snap) {
      return snap.docs
          .map((doc) => Song.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Author? getAuthorById(int id) {
    return AUTHOR_LIST.firstWhere((author) => author.id == id);
  }

  List<Playlist> getAuthorAlbums(Author author) {
    return ALBUM_LIST
        .where((album) => album.authors!.contains(author))
        .toList();
  }

  Playlist getAuthorTopPlaylist(Author author) {
    List<Song> songs =
        SONG_LIST.where((Song song) => song.authors.contains(author)).toList();

    return Playlist(
      id: -1,
      title: author.name + " top 5",
      coverUrl: "",
      playlistType: PlaylistType.artistPlaylist,
      songs: songs,
    );
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
  final List<Playlist> recommended;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late CollectionReference songsRef;
  late CollectionReference playlistsRef;
  late CollectionReference authorsRef;
  late CollectionReference userRef;

  DataState({
    this.recentlyPlayed = const [],
    this.library = const [],
    this.recommended = const [],
  }) {
    songsRef = db.collection("songs");
    playlistsRef = db.collection("playlists");
    authorsRef = db.collection("authors");
    userRef = db.collection("users");
  }

  DataState copyWith({
    List<Playlist>? recentlyPlayed,
    List<Playlist>? library,
    List<Playlist>? recommended,
  }) {
    return DataState(
      recentlyPlayed: recentlyPlayed ?? this.recentlyPlayed,
      library: library ?? this.library,
      recommended: recommended ?? this.recommended,
    );
  }

  static initialState() {
    return DataState(
      recentlyPlayed: [],
      library: [],
      recommended: [],
    );
  }

  @override
  String toString() {
    return '''DataState { data: $recentlyPlayed }''';
  }

  @override
  List<Object?> get props => [];
}
