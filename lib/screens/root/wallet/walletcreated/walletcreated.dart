import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wallet/screens/root/dashboard/dashboard.dart';
import 'package:wallet/utils/global_style.dart';

class WalletCreated extends StatelessWidget {
  final String pubKey;
  final String privkey;
  WalletCreated({required this.pubKey, required this.privkey, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Private Key',
                style: GlobalStyle.addressTitletextStyle,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                privkey,
                style: GlobalStyle.addresstextStyle,
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Public Key',
                style: GlobalStyle.addressTitletextStyle,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                pubKey,
                style: GlobalStyle.addresstextStyle,
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                // await Get.find<UserController>()
                //     .getCurrentUserDoc();
                Get.to(() => Dashboard());
              },
              child: Text('Go'))
        ]),
      ),
    );
  }
}
