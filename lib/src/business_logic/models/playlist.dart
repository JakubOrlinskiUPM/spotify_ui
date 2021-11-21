import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'author.dart';
import 'song.dart';

part 'playlist.g.dart';

@JsonSerializable()
class Playlist extends Equatable {
  const Playlist({required this.id, required this.title, required this.authors, required this.songs, required this.coverUrl});

  final int id;
  final String title;
  final String coverUrl;
  final List<Author> authors;
  final List<Song> songs;

  String get authorString => authors.map((a) => a.name).join(", ");

  @override
  List<Object?> get props => [id];


  factory Playlist.fromJson(Map<String, dynamic> json) => _$PlaylistFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistToJson(this);
}