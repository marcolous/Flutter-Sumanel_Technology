// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_note/utils/routes.dart';
import 'package:firebase_note/utils/show_snack_bar.dart';
import 'package:firebase_note/utils/styles.dart';
import 'package:flutter/material.dart';

class UnVerifiedEmailWidget extends StatelessWidget {
  const UnVerifiedEmailWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await _checkVerifiedEmail(context: context)) {
          ShowSnackBar.show(context, 'Email Already Verified.');
          return;
        } else {
          Navigator.pushNamed(context,Routes.kVerificationScreen);
        }
      },
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text('Unverified Email?', style: Style.style14(context)),
      ),
    );
  }

  Future<bool> _checkVerifiedEmail({required BuildContext context}) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.reload();
        user = FirebaseAuth.instance.currentUser;
        return user!.emailVerified;
      }
    } catch (e) {
      ShowSnackBar.show(context, 'Error checking email verification: $e');
    }
    return false;
  }
}