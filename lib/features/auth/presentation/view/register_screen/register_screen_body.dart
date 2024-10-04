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

class RegisterScreenBody extends StatefulWidget {
  const RegisterScreenBody({
    super.key,
  });

  @override
  State<RegisterScreenBody> createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends State<RegisterScreenBody> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    _userName.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is RegisterSucess) {
          Navigator.pushNamed(context, Routes.kHomeView);
          setState(() {
            isLoading = false;
          });
        } else if (state is RegisterFailure) {
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
                    'Hello! Register to get started',
                    style: Styles.style30Bold(context),
                  ),
                  const Gap(32),
                  EmailTextField(hintText: 'Email', controller: _email),
                  const Gap(12),
                  PasswordTextField(
                      hintText: 'Password', controller: _password),
                  const Gap(12),
                  CustomProgressIndicator(
                    isLoading: isLoading,
                    child: CustomButton(
                      title: 'Register',
                      onPressed: () => _register(
                          email: _email.text.trim(), password: _password.text),
                    ),
                  ),
                  const Gap(35),
                  CustomRow(
                    title: 'Already have an account? ',
                    subTitle: 'Login Now',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Routes.kLoginView);
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

  void _register({required String email, required String password}) async {
    if (_password.text != _confirmPass.text) {
      ShowSnackBar.show(context, 'Password doesn\'t match');
      return;
    }
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context)
          .registerUser(email: email, password: password);
    }
  }
}
