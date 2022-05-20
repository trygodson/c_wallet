import 'package:dapp/models/intromodel.dart';
import 'package:get/get.dart';

class IntroControlller extends GetxController {
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
