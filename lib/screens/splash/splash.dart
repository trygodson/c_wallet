import 'dart:async';

import 'package:wallet/controllers/intro_controller.dart';
import 'package:wallet/screens/intro/intro.dart';
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
  }

  @override
  initState() {
    super.initState();
    _loadResources();
    Timer(
      Duration(seconds: 3),
      () {
        Get.to(() => IntroScreen());
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
