import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'model/user.dart';

class ApiService {
  ApiService._();
  static final ApiService instance = ApiService._();
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://fakestoreapi.com",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<User> requestLogin({
    required String username,
    required String password,
  }) async {
    if (kDebugMode) {
      debugPrint('Login request: username=$username, password=$password');
    }

    late final Response<dynamic> response;
    try {
      response = await dio.post(
        "/auth/login",
        data: {"username": username, "password": password},
      );
    } on DioException catch (error) {
      if (kDebugMode) {
        debugPrint(
          'Login response: status=${error.response?.statusCode}, '
          'body=${_safeResponseBody(error.response?.data)}, '
          'error=${error.message}',
        );
      }
      rethrow;
    }

    if (kDebugMode) {
      debugPrint(
        'Login response: status=${response.statusCode}, '
        'body=${_safeResponseBody(response.data)}',
      );
    }

    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300 &&
        response.data is Map &&
        response.data['token'] is String) {
      final userData = response.data;
      return User.fromJson(userData);
    } else {
      throw Exception("Failed to login");
    }
  }

  dynamic _safeResponseBody(dynamic body) {
    if (body is Map) {
      return body.map((key, value) {

        return MapEntry(key, value);
      });
    }
    return body;
  }
}
