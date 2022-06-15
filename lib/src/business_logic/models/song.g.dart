// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) => Song(
      id: json['id'] as int,
      title: json['title'] as String,
      authors: (json['authors'] as List<dynamic>)
          .map((e) => Author.fromJson(e as Map<String, dynamic>))
          .toList(),
      album: Playlist.fromJson(json['album'] as Map<String, dynamic>),
      storageUrl: json['storageUrl'] as String,
      listenCount: json['listenCount'] as int,
    );

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'authors': instance.authors,
      'album': instance.album,
      'storageUrl': instance.storageUrl,
      'listenCount': instance.listenCount,
    };
