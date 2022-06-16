import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wallet/controllers/authController.dart';
import 'package:wallet/screens/intro/intro.dart';
import 'package:wallet/screens/sign/index.dart';
import 'package:wallet/utils/constraint.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            title: const Text(
              'Profile',
              style: TextStyle(color: Colors.black),
            ),
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await controller.signOut();
                      Get.off(() => SignData());
                    },
                    child: Text('Log out'))
              ]),
        ),
      );
    });
  }
}
