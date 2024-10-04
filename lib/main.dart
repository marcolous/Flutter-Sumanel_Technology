import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sumanel_technology/core/utils/routes.dart';
import 'package:sumanel_technology/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:sumanel_technology/features/auth/presentation/view/login_screen/login_screen.dart';
import 'package:sumanel_technology/features/auth/presentation/view/register_screen/register_screen.dart';
import 'package:sumanel_technology/features/home/presentation/view/home_screen.dart';

void main() {
  runApp(const SamanelTechnology());
}

class SamanelTechnology extends StatelessWidget {
  const SamanelTechnology({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const LoginScreen(),
        routes: {
          Routes.kLoginView: (context) => const LoginScreen(),
          Routes.kRegisterView: (context) => const RegisterScreen(),
          Routes.kHomeView: (context) => const HomeScreen(),
        },
      ),
    );
  }
}
