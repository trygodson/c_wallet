import 'package:clipboard/clipboard.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wallet/controllers/assetcontroller.dart';
import 'package:wallet/controllers/sendtokencontroller.dart';
import 'package:wallet/controllers/usercontroller.dart';
import 'package:wallet/data/repository/tokenRepo.dart';
import 'package:wallet/models/tokenmodel.dart';
import 'package:wallet/utils/appColors.dart';
import 'package:wallet/utils/dimensions.dart';
import 'package:wallet/utils/global_style.dart';

// var product = [
//   RadioModel(
//     false,
//     'SM',
//   ),
//   RadioModel(
//     false,
//     'MD',
//   ),
//   RadioModel(
//     false,
//     'LG',
//   ),
//   RadioModel(
//     false,
//     'XL',
//   ),
//   RadioModel(
//     false,
//     'LG',
//   ),
//   RadioModel(
//     false,
//     'XL',
//   ),
//   RadioModel(
//     false,
//     'LG',
//   ),
//   RadioModel(
//     false,
//     'XL',
//   ),
//   RadioModel(
//     false,
//     'XXL',
//   ),
//   RadioModel(
//     false,
//     'XXL',
//   ),
// ];

class ReceiveTokenBottomSheet extends StatelessWidget {
  // final Product item;

  ReceiveTokenBottomSheet({Key? key}) : super(key: key);

  TextEditingController _amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var publicKey = Get.find<UserController>().currentUserDoc['publicKey'];
    Widget makeDissmable(Widget child) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(),
          child: GestureDetector(
            onTap: () {},
            child: child,
          ),
        );

    return makeDissmable(
      DraggableScrollableSheet(
        minChildSize: 0.45,
        initialChildSize: 0.45,
        builder: (_, c) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.all(20),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Receive Token Address',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )
              ],
            ),
            Container(
              height: Dimensions.getProportionalHeight(210),
              margin: EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Expanded(
                      // child: ListView.builder(
                      //   scrollDirection: Axis.horizontal,
                      //   itemCount: product.length,
                      //   itemBuilder: (ctx, i) => InkWell(
                      //     onTap: () {
                      //       setState(() {
                      //         product.forEach(
                      //             (element) => element.isSelected = false);
                      //         product[i].isSelected = true;
                      //       });
                      //     },
                      //     child: CustomRadioItem(product[i]),
                      //   ),
                      // ),
                      child: Container(
                    width: double.maxFinite,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          QrImage(
                            data: publicKey,
                            size: 200,
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.navyBlue1,
                          ),
                        ]),
                  )),
                ],
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(bottom: Dimensions.getProportionalHeight(10)),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(
                      publicKey,
                      style: GlobalStyle.addresstextStyle,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: Dimensions.getProportionalHeight(50),
              child: ElevatedButton(
                onPressed: () {
                  FlutterClipboard.copy(publicKey).then(
                    (value) => Get.snackbar(
                        'copy success', 'Public Key copied successful'),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    AppColors.navyBlue1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Copy',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.content_copy,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
