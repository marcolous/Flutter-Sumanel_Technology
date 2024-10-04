part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

//! register status
class RegisterLoading extends AuthState {}

class RegisterSucess extends AuthState {}

class RegisterFailure extends AuthState {
  final String errMessage;

  RegisterFailure({required this.errMessage});
}

//! login status
class LoginLoading extends AuthState {}

class LoginSucess extends AuthState {}

class LoginFailure extends AuthState {
  final String errMessage;

  LoginFailure({required this.errMessage});
}
