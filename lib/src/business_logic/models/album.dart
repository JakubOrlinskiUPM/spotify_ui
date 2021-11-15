import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'author.dart';

part 'album.g.dart';

@JsonSerializable()
class Album extends Equatable {
  const Album({required this.id, required this.title, required this.authors, required this.coverUrl});

  final int id;
  final String title;
  final String coverUrl;
  final List<Author> authors;


  @override
  List<Object?> get props => [id];


  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}