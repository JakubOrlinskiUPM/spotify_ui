import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


part 'author_stub.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthorStub extends Equatable {
  const AuthorStub({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  final String id;
  final String name;
  @JsonKey(name: "image_url")
  final String imageUrl;

  @override
  List<Object?> get props => [id];

  factory AuthorStub.fromJson(Map<String, dynamic> json) => _$AuthorStubFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorStubToJson(this);
}