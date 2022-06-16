import 'package:get/get.dart';
import 'package:wallet/controllers/addTokenToAssetController.dart';
import 'package:wallet/controllers/allTokenController.dart';
import 'package:wallet/data/repository/tokenRepo.dart';
import 'package:wallet/screens/alltokens/index.dart';
import 'package:wallet/screens/splash/splash.dart';

class AppRoutes {
  static const String INITIAL_ROUTE = '/';

  static List<GetPage> routes = [
    GetPage(
      name: INITIAL_ROUTE,
      page: () => SplashScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: '/alltoken',
      page: () => AllTokenScreen(),
      transition: Transition.rightToLeft,
      // binding: BindingsBuilder(
      //   () {
      //     Get.lazyPut(() => TokenRepo());
      //     Get.put(() => AllTokenController(tokenRepo: Get.find()),
      //         permanent: true);
      //     Get.put(() => AddTokenToAssetController(), permanent: true);
      //   },
      // ),
    ),
  ];
}
