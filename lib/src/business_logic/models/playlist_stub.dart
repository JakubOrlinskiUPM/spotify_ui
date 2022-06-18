import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


part 'playlist_stub.g.dart';

@JsonSerializable(explicitToJson: true)
class PlaylistStub extends Equatable {
  const PlaylistStub({
    required this.id,
    required this.imageUrl,
    required this.colorHex
  });

  final String id;
  @JsonKey(name: "image_url")
  final String imageUrl;
  @JsonKey(name: "color_hex")
  final int colorHex;


  @override
  List<Object?> get props => [id];

  factory PlaylistStub.fromJson(Map<String, dynamic> json) => _$PlaylistStubFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistStubToJson(this);
}