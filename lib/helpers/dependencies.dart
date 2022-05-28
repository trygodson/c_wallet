import 'package:firebase_core/firebase_core.dart';
import 'package:wallet/controllers/authController.dart';
import 'package:wallet/controllers/intro_controller.dart';
import 'package:get/get.dart';
import 'package:wallet/controllers/usercontroller.dart';
import 'package:wallet/controllers/wallet_creation.dart';
import 'package:wallet/helpers/contractFunction.dart';

Future<void> init() async {
  Get.lazyPut(() => IntroControlller());
  Get.lazyPut(
    () => AuthController(),
  );
  Get.lazyPut(
    () => UserController(),
  );
  Get.lazyPut(
    () => WalletAddressController(),
  );
  Get.lazyPut(
    () => ContractFunctionController(),
  );

  await Firebase.initializeApp();
}
