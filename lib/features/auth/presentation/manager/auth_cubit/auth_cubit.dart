import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sumanel_technology/data/service/auth_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  //! Register cubit
  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    final AuthServices authServices = AuthServices();
    var result = await authServices.registerUser(
      email: email,
      password: password,
    );
    if (result == null) {
      emit(RegisterSucess());
    } else {
      emit(RegisterFailure(errMessage: result.errMessage));
    }
  }

  //! login cubit
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    final AuthServices authServices = AuthServices();
    var result = await authServices.loginUser(
      email: email,
      password: password,
    );
    if (result == null) {
      emit(LoginSucess());
    } else {
      emit(LoginFailure(errMessage: result.errMessage));
    }
  }
}
