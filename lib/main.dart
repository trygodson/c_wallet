import 'package:firebase_core/firebase_core.dart';
import 'package:wallet/controllers/addTokenToAssetController.dart';
import 'package:wallet/controllers/allTokenController.dart';
import 'package:wallet/controllers/assetcontroller.dart';
import 'package:wallet/controllers/authController.dart';
import 'package:wallet/controllers/intro_controller.dart';
import 'package:wallet/controllers/sendtokencontroller.dart';
import 'package:wallet/controllers/usercontroller.dart';
import 'package:wallet/helpers/contractFunction.dart';
import 'package:wallet/routes/routes.dart';
import 'package:wallet/screens/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './helpers/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  dep.init();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(SendTokenController(tokenRepo: Get.find(), web3Repo: Get.find()));
    Get.put(AssetTokenController(web3Repo: Get.find()));
    Get.put(AddTokenToAssetController(tokenRepo: Get.find()));
    Get.put(UserController());

    return GetBuilder<ContractFunctionController>(builder: (_) {
      return GetBuilder<AllTokenController>(builder: (_) {
        return GetBuilder<AuthController>(builder: (_) {
          return GetBuilder<IntroControlller>(builder: (_) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Criset Wallet',
              // initialBinding: dep.InitialBinding(),

              // home: const SplashScreen(),
              initialRoute: AppRoutes.INITIAL_ROUTE,
              getPages: AppRoutes.routes,
            );
          });
        });
      });
    });
  }
}
