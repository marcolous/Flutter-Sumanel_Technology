import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fabu/core/utils/const.dart';
import 'package:fabu/data/services/failures.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthServices {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final Dio _dio = Dio();

  //! Register
  Future<ServerFailure?> registerUser({
    required String email,
    required String password,
    required String password2,
    required String firstName,
    required String lastName,
    required String username,
    required String referralCode,
  }) async {
    final String url = '${Const.userBaseURL}register/';
    _dio.options.contentType = Headers.jsonContentType;

    FormData formData = FormData.fromMap({
      'email': email,
      'password': password,
      'password2': password2,
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'referral_code': referralCode,
    });

    try {
      final Response response = await _dio.post(url, data: formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
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

  //! Verify Account
  Future<ServerFailure?> verifyAccount({
    required String email,
    required String otp,
  }) async {
    final String url = '${Const.userBaseURL}verify/';

    _dio.options.contentType = Headers.jsonContentType;

    FormData formData = FormData.fromMap({
      'email': email,
      'otp': otp,
    });

    try {
      final Response response = await _dio.post(url, data: formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
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

  //! Resend Verify
  Future<ServerFailure?> resendVerify({
    required String email,
  }) async {
    final String url = '${Const.userBaseURL}verify/resend/';

    _dio.options.contentType = Headers.jsonContentType;

    FormData formData = FormData.fromMap({
      'email': email,
    });

    try {
      final Response response = await _dio.post(url, data: formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
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
    required String emailOrUsername,
    required String password,
  }) async {
    final String url = '${Const.userBaseURL}login/';

    _dio.options.contentType = Headers.jsonContentType;

    FormData formData = FormData.fromMap({
      'email_or_username': emailOrUsername,
      'password': password,
    });

    try {
      final Response response = await _dio.post(url, data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = response.data['token'];
        await _secureStorage.write(key: 'auth_token', value: token);
        log(response.data['message']);
        return null;
      } else {
        log(response.data['error']);
        return ServerFailure.fromResponse(response.statusCode!, response.data);
      }
    } on DioException catch (dioError) {
      return ServerFailure.fromDioError(dioError);
    } catch (e) {
      return ServerFailure(errMessage: 'An unexpected error occurred');
    }
  }

  //? Password Change
  Future<ServerFailure?> passwordChange({
    required String email,
    required String password,
    required String confirmPassword,
    required String newPassword,
  }) async {
    final String url = '${Const.userBaseURL}password/change/';

    _dio.options.contentType = Headers.jsonContentType;
    final token = await _secureStorage.read(key: 'auth_token');

    if (token == null) {
      return ServerFailure(errMessage: 'No token found');
    }
    _dio.options.headers = {
      'authorization': 'Token $token',
      'Content-Type': Headers.jsonContentType,
    };

    FormData formData = FormData.fromMap({
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
      'new_password': newPassword,
    });

    try {
      final Response response = await _dio.put(url, data: formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
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

  //! Request Reset
  Future<ServerFailure?> requestReset({
    required String email,
  }) async {
    final String url = '${Const.userBaseURL}password/request-reset/';

    _dio.options.contentType = Headers.jsonContentType;

    FormData formData = FormData.fromMap({
      'email': email,
    });

    try {
      final Response response = await _dio.post(url, data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data['message']);
        return null;
      } else {
        log(response.data['error']);
        return ServerFailure.fromResponse(response.statusCode!, response.data);
      }
    } on DioException catch (dioError) {
      return ServerFailure.fromDioError(dioError);
    } catch (e) {
      return ServerFailure(errMessage: 'An unexpected error occurred');
    }
  }

  //! Request Reset Verify
  Future<ServerFailure?> requestResetVerify({
    required String email,
    required String otp,
  }) async {
    final String url = '${Const.userBaseURL}password/request-reset/verify/';

    _dio.options.contentType = Headers.jsonContentType;

    FormData formData = FormData.fromMap({
      'email': email,
      'otp': otp,
    });

    try {
      final Response response = await _dio.post(url, data: formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data['message']);
        return null;
      } else {
        log(response.data['error']);

        return ServerFailure.fromResponse(response.statusCode!, response.data);
      }
    } on DioException catch (dioError) {
      return ServerFailure.fromDioError(dioError);
    } catch (e) {
      return ServerFailure(errMessage: 'An unexpected error occurred');
    }
  }

  //? Google Auth
  Future<ServerFailure?> googleAuth() async {
    final String url = '${Const.userBaseURL}google/continue/';

    _dio.options.contentType = Headers.jsonContentType;

    try {
      final Response response = await _dio.get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
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

  //! Logout
  Future<ServerFailure?> logoutUser() async {
    final String url = '${Const.userBaseURL}logout/';

    _dio.options.contentType = Headers.jsonContentType;
    final token = await _secureStorage.read(key: 'auth_token');

    if (token == null) {
      return ServerFailure(errMessage: 'No token found');
    }
    _dio.options.headers = {
      'authorization': 'Token $token',
      'Content-Type': Headers.jsonContentType,
    };

    try {
      final Response response = await _dio.post(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        await _secureStorage.delete(key: 'auth_token');

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

  //? delete
  Future<ServerFailure?> deleteAccount() async {
    final String url = '${Const.userBaseURL}delete/';

    _dio.options.contentType = Headers.jsonContentType;

    try {
      final Response response = await _dio.delete(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
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

  //? Email Change
  Future<ServerFailure?> emailChange() async {
    final String url = '${Const.userBaseURL}email/change/';

    _dio.options.contentType = Headers.jsonContentType;
    final token = await _secureStorage.read(key: 'auth_token');

    if (token == null) {
      return ServerFailure(errMessage: 'No token found');
    }
    _dio.options.headers = {
      'authorization': 'Token $token',
      'Content-Type': Headers.jsonContentType,
    };

    try {
      final Response response = await _dio.post(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
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

  //! Password Reset
  Future<ServerFailure?> passwordReset({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final String url = '${Const.userBaseURL}password/reset/';

    _dio.options.contentType = Headers.jsonContentType;

    FormData formData = FormData.fromMap({
      'email': email,
      'new_password': password,
      'confirm_password': confirmPassword,
    });

    try {
      final Response response = await _dio.put(url, data: formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data['message']);

        return null;
      } else {
        log(response.data['error']);
        return ServerFailure.fromResponse(response.statusCode!, response.data);
      }
    } on DioException catch (dioError) {
      return ServerFailure.fromDioError(dioError);
    } catch (e) {
      return ServerFailure(errMessage: 'An unexpected error occurred');
    }
  }

  //? Update Levels
  Future<ServerFailure?> updateLevels() async {
    final String url = '${Const.userBaseURL}update-level/';

    _dio.options.contentType = Headers.jsonContentType;
    final token = await _secureStorage.read(key: 'auth_token');

    if (token == null) {
      return ServerFailure(errMessage: 'No token found');
    }
    _dio.options.headers = {
      'Authorization': 'Token $token',
      'Content-Type': Headers.jsonContentType,
    };

    try {
      final Response response = await _dio.put(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
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
