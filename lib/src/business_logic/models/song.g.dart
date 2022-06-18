// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) => Song(
      id: json['id'] as String,
      name: json['name'] as String,
      album: PlaylistStub.fromJson(json['album'] as Map<String, dynamic>),
      authors: (json['authors'] as List<dynamic>)
          .map((e) => AuthorStub.fromJson(e as Map<String, dynamic>))
          .toList(),
      storageUrl: json['storage_url'] as String,
      storagePath: json['storage_path'] as String,
      listenCount: json['listen_count'] as int,
    );

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'album': instance.album.toJson(),
      'authors': instance.authors.map((e) => e.toJson()).toList(),
      'storage_url': instance.storageUrl,
      'storage_path': instance.storagePath,
      'listen_count': instance.listenCount,
    };
