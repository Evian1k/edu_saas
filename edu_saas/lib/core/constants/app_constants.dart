class AppConstants {
  AppConstants._();

  // Base API
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.example.com',
  );

  // Headers
  static const String headerAuthorization = 'Authorization';
  static const String headerSchoolId = 'X-School-Id';
  static const String headerAccept = 'Accept';
  static const String headerContentType = 'Content-Type';

  // Timeouts (ms)
  static const int connectTimeoutMs = 15000;
  static const int receiveTimeoutMs = 20000;
  static const int sendTimeoutMs = 20000;

  // Storage Keys
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyCurrentUser = 'current_user_json';
  static const String keySchoolId = 'school_id';

  // Roles
  static const String roleOwner = 'owner';
  static const String rolePrincipal = 'principal';
  static const String roleSecretary = 'secretary';
  static const String roleTeacher = 'teacher';
  static const String roleParent = 'parent';
  static const String roleStudent = 'student';
}
