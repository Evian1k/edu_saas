import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:edu_saas/features/auth/bloc/auth_bloc.dart';
import 'package:edu_saas/features/auth/bloc/auth_event.dart';
import 'package:edu_saas/features/auth/bloc/auth_state.dart';
import 'package:edu_saas/features/auth/data/auth_repository.dart';
import 'package:edu_saas/models/user.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository repository;
  late AuthBloc bloc;

  setUp(() {
    repository = MockAuthRepository();
    bloc = AuthBloc(repository);
  });

  blocTest<AuthBloc, AuthState>(
    'emits [Loading, Authenticated] on successful login',
    build: () => bloc,
    setUp: () {
      when(() => repository.login(email: any(named: 'email'), password: any(named: 'password'), schoolId: any(named: 'schoolId')))
          .thenAnswer((_) async => const User(id: '1', name: 'Owner', email: 'o@example.com', role: 'owner'));
    },
    act: (b) => b.add(const AuthLoginRequested(email: 'o@example.com', password: 'secret')),
    expect: () => [isA<AuthLoading>(), isA<AuthAuthenticated>()],
  );

  blocTest<AuthBloc, AuthState>(
    'emits [Loading, Failure] on failed login',
    build: () => bloc,
    setUp: () {
      when(() => repository.login(email: any(named: 'email'), password: any(named: 'password'), schoolId: any(named: 'schoolId')))
          .thenThrow(Exception('invalid credentials'));
    },
    act: (b) => b.add(const AuthLoginRequested(email: 'x@example.com', password: 'bad')),
    expect: () => [isA<AuthLoading>(), isA<AuthFailure>()],
  );
}
