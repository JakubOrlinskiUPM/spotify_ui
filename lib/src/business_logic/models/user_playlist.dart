import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/playlist_type.dart';


part 'user_playlist.g.dart';

@JsonSerializable(explicitToJson: true)
class UserPlaylist extends Equatable {
  const UserPlaylist({
    required this.id,
    required this.lastPlayedAt,
    required this.liked,
    required this.likedAt,
    required this.type,
    required this.name,
  });

  final String id;
  @JsonKey(name: "last_played_at")
  final int lastPlayedAt;
  @JsonKey(name: "liked")
  final bool liked;
  @JsonKey(name: "liked_at")
  final int likedAt;
  @JsonKey(name: "type", fromJson: Playlist.getType, toJson: Playlist.getInt)
  final PlaylistType type;
  @JsonKey(name: "name")
  final String name;


  @override
  List<Object?> get props => [id];

  factory UserPlaylist.fromJson(Map<String, dynamic> json) => _$UserPlaylistFromJson(json);

  Map<String, dynamic> toJson() => _$UserPlaylistToJson(this);
}