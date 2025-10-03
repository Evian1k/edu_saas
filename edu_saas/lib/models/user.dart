import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String role; // owner, principal, secretary, teacher, parent, student
  final String? schoolId; // null for platform owner

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.schoolId,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  bool get isOwner => role == 'owner';

  @override
  List<Object?> get props => [id, email, role, schoolId];
}
