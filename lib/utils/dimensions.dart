import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double getProportionalHeight(double height) {
  return (height / 812.0) * screenHeight;
  }

  static double getProportionalWidth(double width) {
  return (width / 375.0) * screenWidth;
  }
}
