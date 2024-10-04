import 'package:flutter/material.dart';
import 'package:sumanel_technology/features/auth/presentation/view/login_screen/login_screen_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginScreenBody(),
    );
  }
}
