import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wallet/controllers/usercontroller.dart';
import 'package:wallet/screens/root/dashboard/dashboard.dart';
import 'package:wallet/utils/appColors.dart';
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
                'Public Key',
                style: GlobalStyle.addressTitletextStyle,
              ),
              SizedBox(
                height: 20,
              ),
              QrImage(
                data: pubKey,
                size: 200,
                backgroundColor: Colors.white,
                foregroundColor: AppColors.navyBlue1,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration:
                    BoxDecoration(color: AppColors.navyBlue1.withOpacity(0.3)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        pubKey,
                        style: GlobalStyle.addresstextStyle,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            FlutterClipboard.copy(pubKey).then(
                              (value) => Get.snackbar('copy success',
                                  'Public Key copied successful'),
                            );
                          },
                          child: Icon(Icons.content_copy))
                    ]),
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
                await Get.find<UserController>().getCurrentUserDoc();
                Get.to(() => Dashboard());
              },
              child: Text('Go'))
        ]),
      ),
    );
  }
}
