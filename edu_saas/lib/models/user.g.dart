// GENERATED STUB FOR DEV WITHOUT build_runner
// Replace with generated file after running build_runner.

// ignore_for_file: type=lint

part of 'user.dart';

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      schoolId: json['school_id'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'school_id': instance.schoolId,
    };
