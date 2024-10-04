import 'package:firebase_note/utils/routes.dart';
import 'package:firebase_note/utils/styles.dart';
import 'package:flutter/material.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context,Routes.kResetPasswordScreen);
      },
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text('Forgot Password?', style: Style.style14(context)),
      ),
    );
  }
}
