import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable()
class Author extends Equatable {
  const Author({required this.id, required this.name, required this.imageUrl});

  final int id;
  final String name;
  final String imageUrl;


  @override
  List<Object?> get props => [id];


  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}