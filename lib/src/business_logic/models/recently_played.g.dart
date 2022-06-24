// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recently_played.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentlyPlayed _$RecentlyPlayedFromJson(Map<String, dynamic> json) =>
    RecentlyPlayed(
      songId: json['song_id'] as String?,
      playlistId: json['playlist_id'] as String?,
      artistId: json['artist_id'] as String?,
      timestamp: Converters.timestampFromJson(json['timestamp'] as int?),
    );

Map<String, dynamic> _$RecentlyPlayedToJson(RecentlyPlayed instance) =>
    <String, dynamic>{
      'song_id': instance.songId,
      'playlist_id': instance.playlistId,
      'artist_id': instance.artistId,
      'timestamp': Converters.timestampToJson(instance.timestamp),
    };
