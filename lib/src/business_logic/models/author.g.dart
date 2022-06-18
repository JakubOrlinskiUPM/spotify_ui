// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      imagePath: json['image_path'] as String,
      albums:
          (json['albums'] as List<dynamic>).map((e) => e as String).toList(),
      popularSongIds: (json['popular_song_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'image_path': instance.imagePath,
      'albums': instance.albums,
      'popular_song_ids': instance.popularSongIds,
    };
