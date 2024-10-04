import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fabu/core/utils/const.dart';
import 'package:fabu/data/models/user_model/user_model.dart';
import 'package:fabu/data/services/failures.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserDetailsServices {
  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<Either<Failure, UserModel>> fetchUserDetails() async {
    _dio.options.contentType = Headers.jsonContentType;

    try {
      String? token = await _secureStorage.read(key: 'auth_token');

      if (token != null) {
        _dio.options.headers['authorization'] = 'Token $token';
      }
      final response = await _dio.get('${Const.userBaseURL}details/');
      if (response.statusCode == 200 || response.statusCode == 201) {
        UserModel user =
            UserModel.fromJson(response.data as Map<String, dynamic>);
        log(user.username);
        return right(user);
      } else {
        return left(
            ServerFailure.fromResponse(response.statusCode!, response.data));
      }
    } on DioException catch (dioError) {
      return left(ServerFailure.fromDioError(dioError));
    } catch (e) {
      return left(ServerFailure(errMessage: 'An unexpected error occurred'));
    }
  }
}
