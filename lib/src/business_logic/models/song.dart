import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spotify_ui/src/business_logic/models/author.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';

part 'song.g.dart';

@JsonSerializable()
class Song extends Equatable {
  const Song({
    required this.id,
    required this.title,
    required this.authors,
    required this.album,
    required this.storageUrl,
    required this.listenCount,
  });

  final int id;
  final String title;
  final List<Author> authors;
  final Playlist album;
  final String storageUrl;
  final int listenCount;

  String get authorString => authors.map((a) => a.name).join(", ");

  String get heroString => '''${id.toString()}-song-hero''';

  String get listenCountString =>
      NumberFormat.decimalPattern().format(listenCount);

  @override
  List<Object?> get props => [id];

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);

  Map<String, dynamic> toJson() => _$SongToJson(this);
}
