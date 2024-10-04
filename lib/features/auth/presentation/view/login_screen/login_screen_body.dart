
import 'package:firebase_note/cubits/auth_cubit/auth_cubit.dart';
import 'package:firebase_note/customs/custom_back_button.dart';
import 'package:firebase_note/customs/custom_button.dart';
import 'package:firebase_note/customs/custom_google_button.dart';
import 'package:firebase_note/customs/custom_or_with.dart';
import 'package:firebase_note/customs/custom_progress_indicator.dart';
import 'package:firebase_note/customs/custom_row.dart';
import 'package:firebase_note/customs/email_text_field.dart';
import 'package:firebase_note/customs/password_text_field.dart';
import 'package:firebase_note/screens/login_screen/forgot_password_widget.dart';
import 'package:firebase_note/utils/routes.dart';
import 'package:firebase_note/utils/show_snack_bar.dart';
import 'package:firebase_note/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({
    super.key,
  });

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is LoginSuccess) {
          Navigator.pushNamed(context,Routes.kHomeScreen);
          setState(() {
            isLoading = false;
          });
        } else if (state is LoginFailure) {
          ShowSnackBar.show(context, state.errMsg);
          setState(() {
            isLoading = false;
          });
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const CustomBackButton(),
                  const Gap(28),
                  Text(
                    'Welcome back! Glad to see you, Again!',
                    style: Style.style30(context),
                  ),
                  const Gap(32),
                  EmailTextField(
                      hintText: 'Enter your email', controller: _email),
                  const Gap(15),
                  PasswordTextField(
                      hintText: 'Enter your Password', controller: _password),
                  const Gap(15),
                  const ForgotPasswordWidget(),
                  const Gap(30),
                  CustomProgressIndicator(
                    isLoading: isLoading,
                    child: CustomButton(
                      title: 'Login',
                      onPressed: () =>
                          _login(email: _email.text, password: _password.text),
                    ),
                  ),
                  const Gap(35),
                  const CustomOrWith(title: 'Or Login with'),
                  const Gap(22),
                  const CustomGoogleButton(),
                  CustomRow(
                    title: 'Don\'t have an account? ',
                    subTitle: 'Register Now',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context,Routes.kRegisterScreen);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _login({required String email, required String password}) async {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context)
          .login(email: email, password: password);
    }
  }
}
