import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wallet/controllers/authController.dart';
import 'package:wallet/screens/intro/intro.dart';
import 'package:wallet/screens/root/index.dart';
import 'package:wallet/screens/signup/signup_email/signup_email.dart';
import 'package:wallet/utils/constraint.dart';

class SignData extends StatelessWidget {
  const SignData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: firebaseAuth.authStateChanges(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return RootScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Something Went Wrong'),
          );
        } else {
          return IntroScreen();
        }
      },
    ));
  }
}
