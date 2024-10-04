import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumanel_technology/core/utils/const.dart';
import 'package:sumanel_technology/data/service/failures.dart';

class AuthServices {
  final Dio _dio = Dio();

  //! Register
  Future<ServerFailure?> registerUser({
    required String email,
    required String password,
  }) async {
    final String url = '${Const.userBaseURL}register';
    _dio.options.contentType = Headers.jsonContentType;

    Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };

    try {
      log('1');
      final Response response = await _dio.post(url, data: data);

      log(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('2');
        final token = response.data['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        return null;
      } else {
        return ServerFailure.fromResponse(response.statusCode!, response.data);
      }
    } on DioException catch (dioError) {
      return ServerFailure.fromDioError(dioError);
    } catch (e) {
      return ServerFailure(errMessage: 'An unexpected error occurred');
    }
  }

  //! Login
  Future<ServerFailure?> loginUser({
    required String email,
    required String password,
  }) async {
    final String url = '${Const.userBaseURL}login';
    _dio.options.contentType = Headers.jsonContentType;

    Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };

    try {
      final Response response = await _dio.post(url, data: data);
      log(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = response.data['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        return null;
      } else {
        return ServerFailure.fromResponse(response.statusCode!, response.data);
      }
    } on DioException catch (dioError) {
      return ServerFailure.fromDioError(dioError);
    } catch (e) {
      return ServerFailure(errMessage: 'An unexpected error occurred');
    }
  }
}
