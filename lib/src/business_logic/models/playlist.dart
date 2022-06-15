import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spotify_ui/src/business_logic/models/author.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:spotify_ui/src/business_logic/models/user.dart';

part 'playlist.g.dart';

enum PlaylistType { album, userPlaylist, single, podcast, artistPlaylist }

extension PlaylistTypeStringExtension on PlaylistType {
  String get string {
    switch (this) {
      case PlaylistType.album:
        return "Album";
      case PlaylistType.userPlaylist:
        return "Playlist";
      case PlaylistType.single:
        return "EP";
      case PlaylistType.podcast:
        return "Podcast";
      case PlaylistType.artistPlaylist:
        return "Artist Playlist";
      default:
        return "";
    }
  }

  int get integer {
    switch (this) {
      case PlaylistType.album:
        return 0;
      case PlaylistType.userPlaylist:
        return 1;
      case PlaylistType.single:
        return 2;
      case PlaylistType.podcast:
        return 3;
      case PlaylistType.artistPlaylist:
        return 4;
      default:
        return -1;
    }
  }
}

@JsonSerializable()
class Playlist extends Equatable {
  const Playlist({
    required this.id,
    required this.title,
    required this.coverUrl,
    required this.playlistType,
    this.songs,
    this.authors,
    this.userAuthors,
    this.releaseYear = 2020,
    this.colorHex = 0xff3169ba,
  });

  final int id;
  final String title;
  final String coverUrl;
  final List<Song>? songs;
  final List<Author>? authors;
  final List<User>? userAuthors;
  final int colorHex;
  final int releaseYear;

  final PlaylistType playlistType;

  String get authorString => (authors?.map((a) => a.name).join(", ") ?? userAuthors!.map((a) => a.name).join(", "));
  String get heroString => '''${id.toString()}-${playlistType.toString()}-hero''';

  @override
  List<Object?> get props => [id, title, playlistType];

  factory Playlist.fromJson(Map<String, dynamic> json) => _$PlaylistFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistToJson(this);
}
