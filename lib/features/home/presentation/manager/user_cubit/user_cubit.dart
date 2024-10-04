import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sumanel_technology/data/service/user_details_services.dart';
import 'package:sumanel_technology/features/home/presentation/manager/user_cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  Future<void> fetchUserDetails() async {
    emit(UserLoading());
    final UserDetailsServices userDetailsServices = UserDetailsServices();
    var result = await userDetailsServices.fetchUserDetails();
    result.fold((failure) => emit(UserFailure(failure.errMessage)),
        (users) => emit(UserSuccess(users)));
  }
}
