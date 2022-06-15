// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Playlist _$PlaylistFromJson(Map<String, dynamic> json) => Playlist(
      id: json['id'] as int,
      title: json['title'] as String,
      coverUrl: json['coverUrl'] as String,
      playlistType: $enumDecode(_$PlaylistTypeEnumMap, json['playlistType']),
      songs: (json['songs'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      authors: (json['authors'] as List<dynamic>?)
          ?.map((e) => Author.fromJson(e as Map<String, dynamic>))
          .toList(),
      userAuthors: (json['userAuthors'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      releaseYear: json['releaseYear'] as int? ?? 2020,
      colorHex: json['colorHex'] as int? ?? 0xff3169ba,
    );

Map<String, dynamic> _$PlaylistToJson(Playlist instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'coverUrl': instance.coverUrl,
      'songs': instance.songs,
      'authors': instance.authors,
      'userAuthors': instance.userAuthors,
      'colorHex': instance.colorHex,
      'releaseYear': instance.releaseYear,
      'playlistType': _$PlaylistTypeEnumMap[instance.playlistType],
    };

const _$PlaylistTypeEnumMap = {
  PlaylistType.album: 'album',
  PlaylistType.userPlaylist: 'userPlaylist',
  PlaylistType.single: 'single',
  PlaylistType.podcast: 'podcast',
  PlaylistType.artistPlaylist: 'artistPlaylist',
};
