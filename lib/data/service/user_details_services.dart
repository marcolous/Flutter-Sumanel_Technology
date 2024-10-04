import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumanel_technology/core/utils/const.dart';
import 'package:sumanel_technology/data/model/user_model/user_model.dart';
import 'package:sumanel_technology/data/service/failures.dart';

class UserDetailsServices {
  final Dio _dio = Dio();

  Future<Either<Failure, UserModel>> fetchUserDetails() async {
    _dio.options.contentType = Headers.jsonContentType;

    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

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
