import 'package:dio/dio.dart';

import '../core/constants/app_constants.dart';
import '../core/local_storage/local_storage_service.dart';

Dio createDio(LocalStorageService storage) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      connectTimeout: const Duration(milliseconds: AppConstants.connectTimeoutMs),
      receiveTimeout: const Duration(milliseconds: AppConstants.receiveTimeoutMs),
      sendTimeout: const Duration(milliseconds: AppConstants.sendTimeoutMs),
      headers: {
        AppConstants.headerAccept: 'application/json',
        AppConstants.headerContentType: 'application/json',
      },
    ),
  );

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final token = storage.accessToken;
      final schoolId = storage.getSchoolId();
      if (token != null && token.isNotEmpty) {
        options.headers[AppConstants.headerAuthorization] = 'Bearer $token';
      }
      if (schoolId != null && schoolId.isNotEmpty) {
        options.headers[AppConstants.headerSchoolId] = schoolId;
      }
      handler.next(options);
    },
    onError: (e, handler) async {
      // Simplified refresh token logic placeholder
      if (e.response?.statusCode == 401) {
        // TODO: Implement refresh token flow
      }
      handler.next(e);
    },
  ));

  return dio;
}
