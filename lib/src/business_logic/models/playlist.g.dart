// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Playlist _$PlaylistFromJson(Map<String, dynamic> json) => Playlist(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      imagePath: json['image_path'] as String,
      playlistType: Playlist.getType(json['type'] as int),
      songIds:
          (json['song_ids'] as List<dynamic>).map((e) => e as String).toList(),
      authors: (json['authors'] as List<dynamic>)
          .map((e) => AuthorStub.fromJson(e as Map<String, dynamic>))
          .toList(),
      colorHex: json['color_hex'] as int,
      releaseYear: json['release_year'] as int,
      songs: (json['songs'] as List<dynamic>?)
              ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PlaylistToJson(Playlist instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'image_path': instance.imagePath,
      'song_ids': instance.songIds,
      'songs': instance.songs.map((e) => e.toJson()).toList(),
      'authors': instance.authors.map((e) => e.toJson()).toList(),
      'color_hex': instance.colorHex,
      'release_year': instance.releaseYear,
      'type': Playlist.getInt(instance.playlistType),
    };
