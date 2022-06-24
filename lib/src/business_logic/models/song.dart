import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spotify_ui/src/business_logic/models/author.dart';
import 'package:spotify_ui/src/business_logic/models/author_stub.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/playlist_stub.dart';

part 'song.g.dart';

@JsonSerializable(explicitToJson: true)
class Song extends Equatable {
  const Song({
    required this.id,
    required this.name,
    required this.album,
    required this.authors,
    required this.storageUrl,
    required this.storagePath,
    required this.listenCount,
  });

  final String id;
  final String name;
  final PlaylistStub album;
  final List<AuthorStub> authors;
  @JsonKey(name: "storage_url")
  final String storageUrl;
  @JsonKey(name: "storage_path")
  final String storagePath;
  @JsonKey(name: "listen_count")
  final int listenCount;

  String get authorString => authors.map((a) => a.name).join(", ");

  String get heroString => '''${id.toString()}-song-hero''';

  String get listenCountString =>
      NumberFormat.decimalPattern().format(listenCount);

  @override
  List<Object?> get props => [id];

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);

  Map<String, dynamic> toJson() => _$SongToJson(this);

  @override
  String toString() {
    return """Song: ${id}, ${name}""";
  }
}
