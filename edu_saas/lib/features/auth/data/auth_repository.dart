import '../../../models/user.dart';
import '../../../core/local_storage/local_storage_service.dart';
import '../../../services/auth_service.dart';

class AuthRepository {
  final AuthService authService;
  final LocalStorageService localStorageService;

  AuthRepository({
    required this.authService,
    required this.localStorageService,
  });

  Future<User> login({
    required String email,
    required String password,
    String? schoolId,
  }) async {
    final response = await authService.login({
      'email': email,
      'password': password,
      if (schoolId != null) 'school_id': schoolId,
    });

    final body = response.data;
    final access = body['access_token'] as String;
    final refresh = body['refresh_token'] as String;
    final userJson = body['user'] as Map<String, dynamic>;

    await localStorageService.saveTokens(accessToken: access, refreshToken: refresh);
    if (schoolId != null) {
      await localStorageService.saveSchoolId(schoolId);
    } else if (userJson['school_id'] != null) {
      await localStorageService.saveSchoolId(userJson['school_id'] as String);
    }
    await localStorageService.saveCurrentUserJson(userJson);

    return User.fromJson(userJson);
  }

  Future<void> logout() async {
    await localStorageService.clearAll();
  }
}
