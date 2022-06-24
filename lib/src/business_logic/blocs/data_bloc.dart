import 'package:algolia/algolia.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/author.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/playlist_type.dart';
import 'package:spotify_ui/src/business_logic/models/recently_played.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:spotify_ui/src/business_logic/blocs/extensions.dart';
import 'package:spotify_ui/src/business_logic/models/extended_user.dart';
import 'package:spotify_ui/src/business_logic/models/user_playlist.dart';
import 'package:spotify_ui/src/business_logic/models/viewable.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataState.initialState()) {
    on<DataFetchRecentlyPlayed>(_onFetchRecentlyPlayed);
    on<DataFetchRecommended>(_onFetchRecommended);
    on<DataFetchLibrary>(_onFetchLibrary);
    on<DataSetUser>(_onSetUser);
  }

  _onSetUser(DataSetUser event, Emitter<DataState> emit) {
    if (event.user != null) {
      emit(state.copyWith(
        user: Wrapped.value(
          ExtendedUser(
            id: event.user!.uid,
            user: event.user,
          ),
        ),
      ));
    } else {
      emit(state.copyWith(user: Wrapped.value(null)));
    }
  }

  _onFetchRecentlyPlayed(
      DataFetchRecentlyPlayed event, Emitter<DataState> emit) async {
    DocumentSnapshot doc = await state.userRef
        .doc(state.user!.id)
        .collection("recently_played")
        .doc("index")
        .getWithCache();
    var json = doc.data() as Map<String, dynamic>;
    var arr = json['recently_played'];

    List<RecentlyPlayed> recentlyPlayed = arr.map<RecentlyPlayed>((doc) {
      return RecentlyPlayed.fromJson(doc);
    }).toList();

    emit(state.copyWith(
      recentlyPlayed: recentlyPlayed,
    ));
  }

  _onFetchRecommended(
      DataFetchRecommended event, Emitter<DataState> emit) async {
    QuerySnapshot snap = await state.playlistsRef.limit(10).getWithCache();
    var recommended = snap.docs.map((doc) {
      var json = doc.data() as Map<String, dynamic>;
      json['id'] = doc.id;
      return Playlist.fromJson(json);
    }).toList();

    emit(state.copyWith(
      recommended: recommended,
    ));
  }

  _onFetchLibrary(DataFetchLibrary event, Emitter<DataState> emit) async {
    QuerySnapshot snap = await state.userRef
        .doc(state.user?.id)
        .collection("user_playlist")
        .where("liked", isEqualTo: true)
        .getWithCache();

    var recommended = snap.docs.map((doc) {
      var json = doc.data() as Map<String, dynamic>;
      json['id'] = doc.id;
      return UserPlaylist.fromJson(json);
    }).toList();

    emit(state.copyWith(
      library: recommended,
    ));
  }

  addNewUser(String id, Map json) async {
    await state.userRef.doc(id).set(json);
    await state.userRef
        .doc(id)
        .collection("extra_info")
        .doc("liked_songs")
        .set({"my": true});
    await state.userRef.doc(id).collection("recently_played").doc().set({
      "song_id": null,
      "author_id": null,
      "playlist_id": "ZfnXoGPtUNVy3fYhmpJV",
      "timestamp": DateTime.now(),
    });
  }

  Future<Playlist?> getPlaylistById(String id) {
    if (id == "liked_songs") {
      return state.userRef
          .doc(state.user!.id)
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
      playlist.sortSongs();
      return songs;
    });
  }

  Future<Song> getSongById(String id) {
    return state.songsRef.doc(id).getWithCache().then((DocumentSnapshot doc) {
      var json = doc.data() as Map<String, dynamic>;
      json['id'] = doc.id;
      return Song.fromJson(json);
    });
  }

  addRecentlyPlayed(
    String songId,
    Playlist? playlist,
    String? artistId,
  ) {
    DateTime ts = DateTime.now();
    RecentlyPlayed rp = RecentlyPlayed(
      songId: songId,
      playlistId: playlist?.id,
      artistId: artistId,
      timestamp: ts,
    );
    var json = rp.toJson();
    state.userRef
        .doc(state.user!.id)
        .collection("recently_played")
        .doc()
        .set(json);

    json.remove("timestamp");
    json.remove("song_id");
    state.userRef
        .doc(state.user!.id)
        .collection("recently_played")
        .doc('index')
        .update({
      'recently_played': FieldValue.arrayUnion([json]),
    });

    if (playlist != null) {
      state.userRef
          .doc(state.user!.id)
          .collection("user_playlist")
          .doc(playlist.id)
          .get()
          .then((doc) {
        if (doc.exists) {
          state.userRef
              .doc(state.user!.id)
              .collection("user_playlist")
              .doc(playlist.id)
              .update({
            'last_played_at': ts,
          });
        } else {
          state.userRef
              .doc(state.user!.id)
              .collection("user_playlist")
              .doc(playlist.id)
              .set(UserPlaylist(
                id: playlist.id,
                lastPlayedAt: ts,
                liked: false,
                likedAt: null,
                type: playlist.playlistType,
                name: playlist.name,
              ).toJson());
        }
      });
    }
  }

  Future<Viewable> getRecentlyPlayedItem(RecentlyPlayed recentlyPlayed) {
    if (recentlyPlayed.playlistId != null) {
      return state.playlistsRef
          .doc(recentlyPlayed.playlistId)
          .getWithCache()
          .then((DocumentSnapshot doc) {
        var json = doc.data() as Map<String, dynamic>;
        json['id'] = doc.id;
        return Playlist.fromJson(json);
      });
    } else {
      return state.authorsRef
          .doc(recentlyPlayed.artistId)
          .getWithCache()
          .then((DocumentSnapshot doc) {
        var json = doc.data() as Map<String, dynamic>;
        json['id'] = doc.id;
        return Author.fromJson(json);
      });
    }
  }

  Future<Map<String, List<String>>> search(String q) async {
    Map<String, AlgoliaIndexReference> indices = {
      "playlists": state.algolia.index('playlist_index'),
      "songs": state.algolia.index('songs_index'),
      "authors": state.algolia.index('authors_index')
    };
    Map<String, List<String>> results = {};

    for (String key in indices.keys) {
      results[key] = [];
      AlgoliaQuerySnapshot snap = await indices[key]!.query(q).getObjects();

      for (AlgoliaObjectSnapshot hit in snap.hits) {
        results[key]!.add(hit.data['objectID']);
      }
    }
    return results;
  }
}

abstract class DataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DataFetchRecentlyPlayed extends DataEvent {}

class DataFetchRecommended extends DataEvent {}

class DataFetchLibrary extends DataEvent {}

class DataSetUser extends DataEvent {
  User? user;

  DataSetUser({required this.user});
}

class DataFetch extends DataEvent {}

class DataState extends Equatable {
  final List<RecentlyPlayed> recentlyPlayed;
  final List<UserPlaylist> library;
  final List<Playlist> recommended;

  late FirebaseFirestore db;
  late CollectionReference songsRef;
  late CollectionReference playlistsRef;
  late CollectionReference authorsRef;
  late CollectionReference userRef;

  late Algolia algolia;

  ExtendedUser? user;

  DataState({
    this.recentlyPlayed = const [],
    this.library = const [],
    this.recommended = const [],
    this.user,
  }) {
    db = FirebaseFirestore.instance;
    songsRef = db.collection("songs");
    playlistsRef = db.collection("playlists");
    authorsRef = db.collection("authors");
    userRef = db.collection("users");

    algolia = const Algolia.init(
      applicationId: 'JJ38JT9E0R',
      apiKey: 'd76a9a4e457dd35001c2d46ac49d68f2',
    );
  }

  DataState copyWith({
    List<RecentlyPlayed>? recentlyPlayed,
    List<UserPlaylist>? library,
    List<Playlist>? recommended,
    Wrapped<ExtendedUser?>? user,
  }) {
    return DataState(
      recentlyPlayed: recentlyPlayed ?? this.recentlyPlayed,
      library: library ?? this.library,
      recommended: recommended ?? this.recommended,
      user: user != null ? user.value : this.user,
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
    return '''DataState { recentlyPlayed: $recentlyPlayed }''';
  }

  @override
  List<Object?> get props => [recentlyPlayed, library, recommended, user];
}

class Wrapped<T> {
  final T value;

  const Wrapped.value(this.value);
}
