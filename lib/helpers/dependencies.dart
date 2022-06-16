import 'package:firebase_core/firebase_core.dart';
import 'package:wallet/controllers/addTokenToAssetController.dart';
import 'package:wallet/controllers/allTokenController.dart';
import 'package:wallet/controllers/assetcontroller.dart';
import 'package:wallet/controllers/authController.dart';
import 'package:wallet/controllers/intro_controller.dart';
import 'package:get/get.dart';
import 'package:wallet/controllers/sendtokencontroller.dart';
import 'package:wallet/controllers/usercontroller.dart';
import 'package:wallet/controllers/wallet_creation.dart';
import 'package:wallet/data/repository/tokenRepo.dart';
import 'package:wallet/data/repository/web3ClientRepo.dart';
import 'package:wallet/helpers/contractFunction.dart';

init() {
  //Repositories

  Get.lazyPut(
    () => TokenRepo(),
  );
  Get.lazyPut(
    () => Web3ClientRepo(),
  );

//controllers
  Get.lazyPut(() => IntroControlller());
  Get.lazyPut(
    () => AuthController(),
  );
  Get.lazyPut(
    () => UserController(),
  );
  Get.lazyPut(
    () => AddTokenToAssetController(tokenRepo: Get.find()),
  );
  Get.lazyPut(
      () => AllTokenController(
            tokenRepo: Get.find(),
          ),
      fenix: true);
  Get.lazyPut(
    () => SendTokenController(
        tokenRepo: Get.find<TokenRepo>(), web3Repo: Get.find<Web3ClientRepo>()),
  );
  Get.lazyPut(
    () => AssetTokenController(web3Repo: Get.find()),
  );
  Get.lazyPut(
    () => WalletAddressController(),
  );
  Get.lazyPut(
    () => ContractFunctionController(),
  );
}

// class InitialBinding implements Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut(
//       () => TokenRepo(),
//     );
//     Get.lazyPut(
//       () => Web3ClientRepo(),
//     );

// //controllers
//     Get.lazyPut(() => IntroControlller());
//     Get.lazyPut(
//       () => AuthController(),
//     );
//     Get.lazyPut(
//       () => UserController(),
//     );
//     Get.lazyPut(
//       () => AddTokenToAssetController(tokenRepo: Get.find()),
//     );
//     Get.lazyPut(
//       () => AllTokenController(tokenRepo: Get.find()),
//     );
//     Get.lazyPut(
//       () => SendTokenController(tokenRepo: Get.find<TokenRepo>()),
//     );
//     Get.lazyPut(
//       () => AssetTokenController(web3Repo: Get.find()),
//     );
//     Get.lazyPut(
//       () => WalletAddressController(),
//     );
//     Get.lazyPut(
//       () => ContractFunctionController(),
//     );
//   }
// }
