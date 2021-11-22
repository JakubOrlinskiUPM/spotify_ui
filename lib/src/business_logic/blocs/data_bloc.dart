import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_ui/src/business_logic/models/album.dart';
import 'package:spotify_ui/src/business_logic/models/author.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';

const Song s1 = Song(
  album: Album(
    coverUrl:
        'https://i1.wp.com/theseconddisc.com/wp-content/uploads/John-Coltrane-Another-Side-of-John-Coltrane.jpg?fit=1500%2C1472&ssl=1',
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
    coverUrl:
        'https://images-na.ssl-images-amazon.com/images/I/71fij9klnNL._SY355_.jpg',
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

const Playlist p = Playlist(
    title: 'Cool Playlist',
    coverUrl:
        'https://images-na.ssl-images-amazon.com/images/I/71fij9klnNL._SY355_.jpg',
    id: 1,
    authors: [Author(name: 'Engelwood', imageUrl: '', id: 3)],
    songs: [s1, s2, s3, s1, s2, s3, s2, s3, s1, s2, s3]);

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataState.initialState()) {
    on<DataFetchRecentlyPlayed>(_onFetchRecentlyPlayed);
  }

  _onFetchRecentlyPlayed(
      DataFetchRecentlyPlayed event, Emitter<DataState> emit) {
    emit(state.copyWith(
      recentlyPlayed: [p, p, p, p, p, p, p],
    ));
  }

  Playlist? getPlaylistById(int id) {
    state.recentlyPlayed.firstWhere((playlist) => playlist.id == id);
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

  const DataState({
    this.recentlyPlayed = const [],
  });

  DataState copyWith({
    List<Playlist>? recentlyPlayed,
  }) {
    return DataState(
      recentlyPlayed: recentlyPlayed ?? this.recentlyPlayed,
    );
  }

  static initialState() {
    return const DataState(
      recentlyPlayed: [],
    );
  }

  @override
  String toString() {
    return '''DataState { data: $recentlyPlayed }''';
  }

  @override
  List<Object?> get props => [];
}
