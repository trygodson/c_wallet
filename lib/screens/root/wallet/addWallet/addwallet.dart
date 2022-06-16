import 'dart:math';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wallet/controllers/usercontroller.dart';
import 'package:wallet/controllers/wallet_creation.dart';
import 'package:wallet/screens/root/dashboard/dashboard.dart';
import 'package:wallet/screens/root/wallet/walletcreated/walletcreated.dart';
import 'package:wallet/utils/appColors.dart';
import 'package:wallet/utils/dimensions.dart';
import 'package:wallet/utils/global_style.dart';

class AddWallet extends StatelessWidget {
  String mnemonic;
  bool loading = false;
  AddWallet({required this.mnemonic, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listmnemonic = mnemonic.split(" ");
    return Scaffold(body: GetBuilder<UserController>(builder: (usercontroller) {
      return Container(
        width: Dimensions.screenWidth,
        height: Dimensions.screenHeight,
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.getProportionalHeight(20),
            vertical: Dimensions.getProportionalHeight(40)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: Dimensions.getProportionalHeight(250),
                width: Dimensions.screenWidth * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColors.navyBlue1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Wrap(alignment: WrapAlignment.center, children: [
                      for (var i = 0; i < listmnemonic.length; i++)
                        RichText(
                            text: TextSpan(
                                text: '${i + 1} ',
                                style: TextStyle(
                                    height: 1.3,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.primaries[Random()
                                        .nextInt(Colors.primaries.length)]),
                                children: [
                              TextSpan(
                                text: '${listmnemonic[i]}  ',
                                style: TextStyle(
                                    height: 1.5,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                    color: Colors.black),
                              )
                            ]))
                    ]),
                    InkWell(
                      onTap: () {
                        FlutterClipboard.copy(mnemonic).then(
                          (value) => Get.snackbar('copy success',
                              '12 word phase copied successful'),
                        );
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: 35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Copy',
                              style: TextStyle(
                                  color: AppColors.navyBlue1,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: Dimensions.getProportionalWidth(20),
                            ),
                            Icon(Icons.content_copy)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  usercontroller.addUserDetails(mnemonic);
                },
                child: Container(
                  color: Color.fromARGB(255, 5, 21, 34),
                  width: Dimensions.screenWidth * 0.76,
                  height: Dimensions.getProportionalHeight(50),
                  child: Center(
                    child: usercontroller.loading
                        ? CircularProgressIndicator(
                            strokeWidth: 2,
                          )
                        : Text(
                            'Generate Wallet',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }));
  }
}
