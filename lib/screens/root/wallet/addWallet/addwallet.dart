import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wallet/controllers/usercontroller.dart';
import 'package:wallet/controllers/wallet_creation.dart';
import 'package:wallet/screens/root/dashboard/dashboard.dart';
import 'package:wallet/screens/root/wallet/walletcreated/walletcreated.dart';
import 'package:wallet/utils/dimensions.dart';
import 'package:wallet/utils/global_style.dart';

class AddWallet extends StatelessWidget {
  String mnemonic;
  AddWallet({required this.mnemonic, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Text(
                mnemonic,
                style: GlobalStyle.addresstextStyle,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  final walletcontroller = Get.find<WalletAddressController>();
                  final privKey =
                      await walletcontroller.getPrivateKey(mnemonic);
                  final pubKey = await walletcontroller.getPublicKey(privKey);
                  usercontroller.addUserDetails(privKey, pubKey);
                  Get.off(() => WalletCreated(
                        privkey: privKey,
                        pubKey: pubKey.toString(),
                      ));
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
