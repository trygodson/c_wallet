import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallet/controllers/authController.dart';
import 'package:wallet/controllers/intro_controller.dart';
import 'package:wallet/screens/intro/intro.dart';
import 'package:wallet/screens/root/index.dart';
import 'package:wallet/screens/sign/index.dart';
import 'package:wallet/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _loadResources() async {
    await Get.find<IntroControlller>();
    await Get.find<AuthController>();
  }

  // late User? user;

  @override
  initState() {
    super.initState();
    _loadResources();
    Timer(
      Duration(seconds: 3),
      () {
        //  user = Get.find<IntroControlller>().user as User;

        Get.offAll(() => SignData());
        // if (Get.find<AuthController>().user == null) {
        // } else {
        //   Get.offAll(() => RootScreen());
        // }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
              child: Text(
            'Criset Wallet',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          )),
        ],
      ),
    );
  }
}
