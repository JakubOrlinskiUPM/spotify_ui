import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/author.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:spotify_ui/src/business_logic/blocs/extensions.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataState.initialState()) {
    on<DataFetchRecentlyPlayed>(_onFetchRecentlyPlayed);
  }

  _onFetchRecentlyPlayed(
      DataFetchRecentlyPlayed event, Emitter<DataState> emit) async {
    QuerySnapshot snap = await state.playlistsRef.getWithCache();
    var playlists = snap.docs.map((doc) {
      var json = doc.data() as Map<String, dynamic>;
      json['id'] = doc.id;
      return Playlist.fromJson(json);
    }).toList();

    DocumentSnapshot likedSongs = await state.userRef
        .doc("oRdyRNXgFXezoncEHVSGi6Gyzfw2")
        .collection("extra_info")
        .doc("liked_songs")
        .getWithCache();

    var json = likedSongs.data() as Map<String, dynamic>;
    json['id'] = 'liked_songs';
    playlists.insert(0, Playlist.fromJson(json));

    emit(state.copyWith(
      recentlyPlayed: playlists,
      library: playlists,
      recommended: playlists,
    ));
  }

  Future<Playlist?> getPlaylistById(String id) {
    if (id == "liked_songs") {
      return state.userRef
          .doc("oRdyRNXgFXezoncEHVSGi6Gyzfw2")
          .collection("extra_info")
          .doc(id)
          .getWithCache()
          .then((DocumentSnapshot doc) {
        final json = doc.data() as Map<String, dynamic>;
        json['id'] = doc.id;
        return Playlist.fromJson(json);
      });
    } else {
      return state.playlistsRef
          .doc(id)
          .getWithCache()
          .then((DocumentSnapshot doc) {
        final json = doc.data() as Map<String, dynamic>;
        json['id'] = doc.id;
        return Playlist.fromJson(json);
      });
    }
  }

  Future<Author?> getAuthorById(String id) {
    return state.authorsRef.doc(id).getWithCache().then((DocumentSnapshot doc) {
      final json = doc.data() as Map<String, dynamic>;
      json['id'] = doc.id;
      return Author.fromJson(json);
    });
  }

  Future<Playlist?> getAuthorPlaylist(Author author) {
    return state.songsRef
        .where(FieldPath.documentId, whereIn: author.popularSongIds)
        .getWithCache()
        .then((QuerySnapshot snap) {
      List<Song> songs = snap.docs.map((doc) {
        final json = doc.data() as Map<String, dynamic>;
        json['id'] = doc.id;
        return Song.fromJson(json);
      }).toList();

      return Playlist.authorPlaylist(author, songs);
    });
  }

  Future<List<Playlist>> getAuthorAlbums(Author author) {
    return state.playlistsRef
        .where(FieldPath.documentId, whereIn: author.albums)
        .getWithCache()
        .then((QuerySnapshot snap) {
      List<Playlist> albums = snap.docs.map((doc) {
        final json = doc.data() as Map<String, dynamic>;
        json['id'] = doc.id;
        return Playlist.fromJson(json);
      }).toList();

      return albums;
    });
  }

  Future<List<Song>> getPlaylistSongs(Playlist playlist) {
    return state.songsRef
        .where(FieldPath.documentId, whereIn: playlist.songIds)
        .getWithCache()
        .then((QuerySnapshot snap) {
      List<Song> songs = snap.docs.map((doc) {
        var json = doc.data() as Map<String, dynamic>;
        json['id'] = doc.id;
        return Song.fromJson(json);
      }).toList();
      songs.sort((Song s1, Song s2) =>
          playlist.songIds.indexOf(s1.id) - playlist.songIds.indexOf(s2.id));
      playlist.songs = songs;
      return songs;
    });
  }

  Future<Song> getSong(String id) {
    return state.songsRef.doc(id).getWithCache().then((DocumentSnapshot doc) {
      var json = doc.data() as Map<String, dynamic>;
      json['id'] = doc.id;
      return Song.fromJson(json);
    });
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

  late FirebaseFirestore db;
  late CollectionReference songsRef;
  late CollectionReference playlistsRef;
  late CollectionReference authorsRef;
  late CollectionReference userRef;

  DataState({
    this.recentlyPlayed = const [],
    this.library = const [],
    this.recommended = const [],
  }) {
    db = FirebaseFirestore.instance;
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
