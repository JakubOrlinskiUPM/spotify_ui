// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_stub.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistStub _$PlaylistStubFromJson(Map<String, dynamic> json) => PlaylistStub(
      id: json['id'] as String,
      imageUrl: json['image_url'] as String,
      colorHex: json['color_hex'] as int,
    );

Map<String, dynamic> _$PlaylistStubToJson(PlaylistStub instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image_url': instance.imageUrl,
      'color_hex': instance.colorHex,
    };
