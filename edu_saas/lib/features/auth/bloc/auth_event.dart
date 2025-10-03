import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  final String? schoolId;

  const AuthLoginRequested({
    required this.email,
    required this.password,
    this.schoolId,
  });

  @override
  List<Object?> get props => [email, schoolId];
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}
