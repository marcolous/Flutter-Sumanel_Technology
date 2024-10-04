import 'package:sumanel_technology/data/model/user_model/user_model.dart';

abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final List<User> user;

  const UserSuccess(this.user);
}

class UserFailure extends UserState {
  final String errMessage;

  const UserFailure(this.errMessage);
}
