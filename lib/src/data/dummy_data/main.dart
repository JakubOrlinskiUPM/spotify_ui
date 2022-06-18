import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_ui/src/business_logic/models/author.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:spotify_ui/src/data/dummy_data/albums.dart';
import 'package:spotify_ui/src/data/dummy_data/authors.dart';
import 'package:spotify_ui/src/data/dummy_data/playlists.dart';
import 'package:spotify_ui/src/data/dummy_data/songs.dart';


syncDummySongs() {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference songsRef = db.collection("songs");

  for (Song song in songs) {
    var json = song.toJson();
    json.remove('id');
    songsRef.doc(song.id).set(json);
  }
}

syncDummyAlbums() {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference playlistsRef = db.collection("playlists");

  for (Playlist album in albums) {
    var json = album.toJson();
    json.remove('id');
    playlistsRef.doc(album.id).set(json);
  }
}

syncDummyPlaylists() {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference playlistsRef = db.collection("playlists");

  for (Playlist playlist in playlists) {
    var json = playlist.toJson();
    json.remove('id');
    playlistsRef.doc(playlist.id).set(json);
  }
}

syncDummyAuthors() {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference authorsRef = db.collection("authors");

  for (Author author in authors) {
    var json = author.toJson();
    json.remove('id');
    authorsRef.doc(author.id).set(json);
  }
}


// syncDummyUsers() {
//   FirebaseFirestore db = FirebaseFirestore.instance;
//   CollectionReference userRef = db.collection("users");
//
//   for (User user in user) {
//     var json = album.toJson();
//     json.remove('id');
//     userRef.doc(album.id).set(json);
//   }
// }


