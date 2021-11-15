import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'author.dart';

part 'playlist.g.dart';

@JsonSerializable()
class Playlist extends Equatable {
  const Playlist({required this.id, required this.title, required this.authors, required this.coverUrl});

  final int id;
  final String title;
  final String coverUrl;
  final List<Author> authors;


  @override
  List<Object?> get props => [id];


  factory Playlist.fromJson(Map<String, dynamic> json) => _$PlaylistFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistToJson(this);
}