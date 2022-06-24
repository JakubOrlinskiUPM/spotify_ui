import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spotify_ui/src/business_logic/models/author.dart';
import 'package:spotify_ui/src/business_logic/models/playlist_type.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:spotify_ui/src/business_logic/models/viewable.dart';

import 'author_stub.dart';

part 'playlist.g.dart';

@JsonSerializable(explicitToJson: true)
class Playlist extends Equatable implements Viewable {
  Playlist({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.imagePath,
    required this.playlistType,
    required this.songIds,
    required this.authors,
    required this.colorHex,
    required this.releaseYear,
    this.songs = const [],
  });

  final String id;
  final String name;
  @JsonKey(name: "image_url")
  final String imageUrl;
  @JsonKey(name: "image_path")
  final String imagePath;
  @JsonKey(name: "song_ids")
  final List<String> songIds;
  List<Song> songs;
  final List<AuthorStub> authors;
  @JsonKey(name: "color_hex")
  final int colorHex;
  @JsonKey(name: "release_year")
  final int releaseYear;
  @JsonKey(name: "type", fromJson: getType, toJson: getInt)
  final PlaylistType playlistType;

  String get authorString => (authors.map((a) => a.name).join(", "));

  String get heroString =>
      '''${id.toString()}-${playlistType.toString()}-hero''';

  void sortSongs([Song? song]) {
    if (song != null && !songs.contains(song)) {
      songs.add(song);
    }
    songs.sort(
        (Song s1, Song s2) => songIds.indexOf(s1.id) - songIds.indexOf(s2.id));
  }

  @override
  List<Object?> get props => [id, name, playlistType, songs];

  factory Playlist.fromJson(Map<String, dynamic> json) =>
      _$PlaylistFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistToJson(this);

  static Playlist authorPlaylist(Author author, List<Song> songs) {
    return Playlist(
        id: "",
        name: author.name,
        imageUrl: "",
        imagePath: "",
        playlistType: PlaylistType.artistPlaylist,
        songIds: [],
        songs: songs,
        authors: [],
        colorHex: 0,
        releaseYear: 0);
  }

  static int getInt(PlaylistType pt) {
    return pt.integer;
  }

  static PlaylistType getType(int type) {
    switch (type) {
      case 0:
        return PlaylistType.album;
      case 1:
        return PlaylistType.userPlaylist;
      case 2:
        return PlaylistType.single;
      case 3:
        return PlaylistType.podcast;
      case 4:
        return PlaylistType.artistPlaylist;
      default:
        return PlaylistType.userPlaylist;
    }
  }
}
