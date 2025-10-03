// GENERATED STUB FOR DEV WITHOUT build_runner
// Replace with generated file after running build_runner.

// ignore_for_file: type=lint

part of 'auth_service.dart';

class _AuthService implements AuthService {
  _AuthService(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<Map<String, dynamic>>> login(Map<String, dynamic> body) async {
    final response = await _dio.post<Map<String, dynamic>>('/auth/login', data: body);
    return HttpResponse(response.data ?? <String, dynamic>{}, response);
  }
}
