import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spotify_ui/src/business_logic/models/viewable.dart';

part 'author.g.dart';

@JsonSerializable()
class Author extends Equatable implements Viewable {
  const Author({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.imagePath,
    required this.albums,
    required this.popularSongIds,
  });

  final String id;
  final String name;
  @JsonKey(name: "image_url")
  final String imageUrl;
  @JsonKey(name: "image_path")
  final String imagePath;
  final List<String> albums;
  @JsonKey(name: "popular_song_ids")
  final List<String> popularSongIds;

  String get heroString => '''${id.toString()}-hero''';

  @override
  List<Object?> get props => [id];

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}
