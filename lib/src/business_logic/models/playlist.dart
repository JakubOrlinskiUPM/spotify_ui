import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spotify_ui/src/business_logic/models/author.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:spotify_ui/src/business_logic/models/user.dart';

part 'playlist.g.dart';

enum PlaylistType { album, userPlaylist, single, podcast }

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
      default:
        return "";
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
  });

  final int id;
  final String title;
  final String coverUrl;
  final List<Song>? songs;
  final List<Author>? authors;
  final List<User>? userAuthors;

  final PlaylistType playlistType;

  String get authorString => (authors?.map((a) => a.name).join(", ") ?? userAuthors!.map((a) => a.name).join(", "));
  String get heroString => '''${id.toString()}-${playlistType.toString()}-hero''';

  @override
  List<Object?> get props => [id, playlistType];

  factory Playlist.fromJson(Map<String, dynamic> json) => _$PlaylistFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistToJson(this);
}
