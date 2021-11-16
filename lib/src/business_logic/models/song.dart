import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'album.dart';
import 'author.dart';


part 'song.g.dart';

@JsonSerializable()
class Song extends Equatable {
  const Song({required this.id, required this.title, required this.authors, required this.album, required this.storageUrl});

  final int id;
  final String title;
  final List<Author> authors;
  final Album album;
  final String storageUrl;


  @override
  List<Object?> get props => [id];

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);

  Map<String, dynamic> toJson() => _$SongToJson(this);
}
