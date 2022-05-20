import 'package:flutter/material.dart';
import 'package:wallet/screens/root/dashboard/dashboard.dart';
import 'package:wallet/utils/appColors.dart';
import 'package:wallet/utils/dimensions.dart';
import 'package:wallet/widgets/bottombar_item.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootScreen> {
  int activeTab = 0;
  List barItems = [
    {
      "icon": Icons.home_outlined,
      "active_icon": Icons.home_rounded,
      "page": Dashboard(),
      "title": ""
    },
    {
      "icon": Icons.search_outlined,
      "active_icon": Icons.account_balance_wallet_outlined,
      "page": Container(
        child: Center(
          child: Text('Wallet'),
        ),
      ),
      "title": ""
    },
    {
      "icon": Icons.favorite_border,
      "active_icon": Icons.favorite_outlined,
      "page": Container(
        child: Center(
          child: Text('send and receive'),
        ),
      ),
      "title": ""
    },
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
      "icon": Icons.settings_outlined,
      "active_icon": Icons.settings_rounded,
      "page": Container(
        child: Center(
          child: Text('Settings'),
        ),
      ),
      "title": ""
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: appBgColor,
      body: getBarPage(),
      // bottomNavigationBar: getBottomBar1()
      floatingActionButton: getBottomBar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  Widget getBarPage() {
    return IndexedStack(
      index: activeTab,
      children: List.generate(
        barItems.length,
        (index) => barItems[index]["page"],
      ),
    );
  }

  Widget getBottomBar() {
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
          barItems.length,
          (index) => BottomBarItem(
            activeTab == index
                ? barItems[index]["active_icon"]
                : barItems[index]["icon"],
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
