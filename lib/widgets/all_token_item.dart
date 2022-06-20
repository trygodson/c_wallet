import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet/controllers/addTokenToAssetController.dart';
import 'package:wallet/controllers/assetcontroller.dart';
import 'package:wallet/models/tokenmodel.dart';
import 'package:wallet/utils/appColors.dart';
import 'package:wallet/widgets/title_text.dart';

class AllTokenItem extends StatelessWidget {
  // final TokenModel token;
  String tokenname;
  String tokensymbol;
  String address;
  bool taken;
  Function? func;

  AllTokenItem(
      {required this.tokenname,
      required this.tokensymbol,
      required this.taken,
      this.func,
      required this.address,
      Key? key})
      : super(key: key);
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    var switchController = Get.find<AssetTokenController>();
    // bool truth = token.taken;
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: AppColors.navyBlue1,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Icon(Icons.hd, color: Colors.white),
      ),
      contentPadding: EdgeInsets.symmetric(),
      title: TitleText(
        text: '${tokenname} ${tokensymbol}',
        fontSize: 14,
      ),
      // subtitle: Text("23 Feb 2020"),
      trailing: Container(
        height: 30,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.lightGrey.withOpacity(0.4),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ValueBuilder<bool>(
          initialValue: taken,
          builder: (taken, updatefn) {
            return Switch(
              key: ValueKey(tokenname),
              value: taken,
              onChanged: (val) {
                if (val) {
                  switchController.addTokenToAssetToken(TokenModel(
                      tokenName: tokenname,
                      deployedAddress: address,
                      tokenSymbol: tokensymbol,
                      taken: taken));
                  updatefn(val);
                  func!();
                } else if (!val) {
                  switchController.removeTokenToAssetToken(TokenModel(
                      tokenName: tokenname,
                      deployedAddress: address,
                      tokenSymbol: tokensymbol,
                      taken: taken));
                  updatefn(val);
                  func!();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
