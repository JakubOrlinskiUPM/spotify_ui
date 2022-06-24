import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spotify_ui/src/business_logic/utils/converters.dart';

part 'recently_played.g.dart';

@JsonSerializable(explicitToJson: true)
class RecentlyPlayed extends Equatable {
  const RecentlyPlayed({this.songId, this.playlistId, this.artistId, this.timestamp});

  @JsonKey(name: "song_id")
  final String? songId;
  @JsonKey(name: "playlist_id")
  final String? playlistId;
  @JsonKey(name: "artist_id")
  final String? artistId;
  @JsonKey(fromJson: Converters.timestampFromJson, toJson: Converters.timestampToJson)
  final DateTime? timestamp;

  @override
  List<Object?> get props => [songId, playlistId, artistId, ];

  factory RecentlyPlayed.fromJson(Map<String, dynamic> json) => _$RecentlyPlayedFromJson(json);

  Map<String, dynamic> toJson() => _$RecentlyPlayedToJson(this);
}

