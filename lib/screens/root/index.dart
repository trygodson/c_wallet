import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:wallet/controllers/assetcontroller.dart';
import 'package:wallet/controllers/usercontroller.dart';
import 'package:wallet/helpers/contractFunction.dart';
import 'package:wallet/screens/root/dashboard/dashboard.dart';
import 'package:wallet/screens/root/profile/profile.dart';
import 'package:wallet/screens/root/wallet/wallet.dart' as walletscreen;
import 'package:wallet/utils/appColors.dart';
import 'package:wallet/utils/constraint.dart';
import 'package:wallet/utils/dimensions.dart';
import 'package:wallet/widgets/bottombar_item.dart';
import 'package:web3dart/web3dart.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootScreen> {
  Web3Client? ethClient;
  Client? httpClient;
  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infruraUrl, httpClient!);
    Get.put(ContractFunctionController());
    Get.find<AssetTokenController>().getBalance();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RootScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  int activeTab = 0;
  List barItems(r) {
    return [
      {
        "icon": Icons.account_balance_wallet_outlined,
        "active_icon": Icons.account_balance_wallet,
        "page": Dashboard(notifyParent: r),
        "title": ""
      },
      // {
      //   "icon": Icons.account_balance_wallet_outlined,
      //   "active_icon": Icons.account_balance_wallet,
      //   "page": walletscreen.Wallet(),
      //   "title": ""
      // },
      {
        "icon": Icons.forum_outlined,
        "active_icon": Icons.forum_rounded,
        "page": Container(
          child: Center(
            child: Text('KYC'),
          ),
        ),
        "title": ""
      },
      {
        "icon": Icons.person_outline,
        "active_icon": Icons.person,
        "page": ProfileScreen(),
        "title": ""
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    refresh() {
      setState(() {});
    }

    return Scaffold(
      // backgroundColor: appBgColor,
      body: getBarPage(refresh),
      // bottomNavigationBar: getBottomBar1()
      floatingActionButton: getBottomBar(refresh),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
    // return GetBuilder<UserController>(builder: (controller) {
    // });
  }

  Widget getBarPage(r) {
    return IndexedStack(
      index: activeTab,
      children: List.generate(
        barItems(r).length,
        (index) => barItems(r)[index]["page"],
      ),
    );
  }

  Widget getBottomBar(r) {
    return Container(
      height: 55,
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(
          Dimensions.getProportionalHeight(15),
          0,
          Dimensions.getProportionalHeight(15),
          Dimensions.getProportionalHeight(10)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(Dimensions.getProportionalHeight(20)),
        boxShadow: [
          BoxShadow(
              color: AppColors.darkgrey.withOpacity(0.1),
              blurRadius: 1,
              spreadRadius: 1,
              offset: const Offset(0, 1))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          barItems(r).length,
          (index) => BottomBarItem(
            activeTab == index
                ? barItems(r)[index]["active_icon"]
                : barItems(r)[index]["icon"],
            "",
            isActive: activeTab == index,
            activeColor: AppColors.lightNavyBlue,
            onTap: () {
              setState(() {
                activeTab = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
