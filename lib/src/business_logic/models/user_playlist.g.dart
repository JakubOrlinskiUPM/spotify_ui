// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPlaylist _$UserPlaylistFromJson(Map<String, dynamic> json) => UserPlaylist(
      id: json['id'] as String,
      lastPlayedAt: json['last_played_at'] as int,
      liked: json['liked'] as bool,
      likedAt: json['liked_at'] as int,
      type: Playlist.getType(json['type'] as int),
      name: json['name'] as String,
    );

Map<String, dynamic> _$UserPlaylistToJson(UserPlaylist instance) =>
    <String, dynamic>{
      'id': instance.id,
      'last_played_at': instance.lastPlayedAt,
      'liked': instance.liked,
      'liked_at': instance.likedAt,
      'type': Playlist.getInt(instance.type),
      'name': instance.name,
    };
