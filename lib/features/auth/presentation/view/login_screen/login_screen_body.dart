import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sumanel_technology/core/utils/routes.dart';
import 'package:sumanel_technology/core/utils/show_snack_bar.dart';
import 'package:sumanel_technology/core/utils/styles.dart';
import 'package:sumanel_technology/core/widgets/custom_back_button.dart';
import 'package:sumanel_technology/core/widgets/custom_button.dart';
import 'package:sumanel_technology/core/widgets/custom_progress_indicator.dart';
import 'package:sumanel_technology/core/widgets/custom_row.dart';
import 'package:sumanel_technology/core/widgets/email_text_field.dart';
import 'package:sumanel_technology/core/widgets/password_text_field.dart';
import 'package:sumanel_technology/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';

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
        } else if (state is LoginSucess) {
          Navigator.pushNamed(context, Routes.kHomeView);
          setState(() {
            isLoading = false;
          });
        } else if (state is LoginFailure) {
          ShowSnackBar.show(context, state.errMessage);
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
                    style: Styles.style30Bold(context),
                  ),
                  const Gap(32),
                  EmailTextField(
                      hintText: 'Enter your email', controller: _email),
                  const Gap(15),
                  PasswordTextField(
                      hintText: 'Enter your Password', controller: _password),
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
                  CustomRow(
                    title: 'Don\'t have an account? ',
                    subTitle: 'Register Now',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Routes.kRegisterView);
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
          .loginUser(email: email, password: password);
    }
  }
}
