import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'extended_user.g.dart';

@JsonSerializable(explicitToJson: true)
class ExtendedUser extends Equatable {
  const ExtendedUser({required this.id, this.user});

  final String id;
  @JsonKey(ignore: true)
  final User? user;
  
  @override
  List<Object?> get props => [id];


  factory ExtendedUser.fromJson(Map<String, dynamic> json) => _$ExtendedUserFromJson(json);

  Map<String, dynamic> toJson() => _$ExtendedUserToJson(this);
}