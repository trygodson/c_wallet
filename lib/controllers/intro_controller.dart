import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallet/models/intromodel.dart';
import 'package:get/get.dart';
import 'package:wallet/screens/intro/intro.dart';
import 'package:wallet/screens/root/dashboard/dashboard.dart';
import 'package:wallet/screens/signup/signup_email/signup_email.dart';
import 'package:wallet/utils/constraint.dart';

class IntroControlller extends GetxController {
  late Rx<User?> _user;

  List<IntroModel> sliderStuffs = [
    IntroModel(
        imagePath: 'assets/image/image.png',
        title: 'The Most trusted Crypto wallet',
        otherText: 'we help our users make the best financial decision'),
    IntroModel(
        imagePath: 'assets/image/image.png',
        title: 'Receive and Send Money to Friends',
        otherText: 'we help our users make the best financial decision'),
    IntroModel(
        imagePath: 'assets/image/image.png',
        title: 'Your Safety is our top priority',
        otherText: 'we help our users make the best financial decision'),
  ];
}
