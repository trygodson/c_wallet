import 'package:wallet/controllers/intro_controller.dart';
import 'package:get/get.dart';

Future<void> init() async {
  Get.lazyPut(() => IntroControlller());
}
