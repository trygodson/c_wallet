import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet/helpers/contractFunction.dart';
import 'package:wallet/utils/appColors.dart';
import 'package:wallet/utils/dimensions.dart';
import 'package:wallet/utils/global_style.dart';
import 'package:wallet/widgets/custom_transaction_icon.dart';

class Wallet extends StatelessWidget {
  Wallet({Key? key}) : super(key: key);
  var contractcontroller = Get.find<ContractFunctionController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: const Size.fromHeight(50),
        //   child: AppBar(
        //     backgroundColor: Colors.white,
        //     centerTitle: true,
        //     elevation: 0,
        //     title: const Text(
        //       'Wallet',
        //       style: TextStyle(color: Colors.black),
        //     ),
        //     iconTheme: IconThemeData(color: Colors.black),
        //   ),
        // ),
        body: Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            width: double.maxFinite,
            height: Dimensions.getProportionalHeight(250),
            padding: EdgeInsets.only(
              top: Dimensions.getProportionalHeight(45),
            ),
            decoration:
                BoxDecoration(color: Color.fromARGB(179, 245, 239, 239)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Total Balance',
                  style: GlobalStyle.balanceTitlePriceStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '\$ ${contractcontroller.balance}',
                  style: GlobalStyle.balancePriceStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    children: [
                      CustomTransactionIcon(
                        icon: Icons.arrow_upward_sharp,
                        text: "Send",
                        size: Dimensions.getProportionalWidth(60),
                      ),
                      CustomTransactionIcon(
                        icon: Icons.arrow_downward_sharp,
                        text: "Receive",
                        size: Dimensions.getProportionalWidth(60),
                      ),
                      CustomTransactionIcon(
                        icon: Icons.tag_sharp,
                        text: "Buy",
                        size: Dimensions.getProportionalWidth(60),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: Dimensions.getProportionalHeight(250) -
              Dimensions.getProportionalHeight(20),
          bottom: 0,
          child: Container(
            padding: EdgeInsets.all(
              Dimensions.getProportionalHeight(20),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft:
                        Radius.circular(Dimensions.getProportionalHeight(15)),
                    topRight:
                        Radius.circular(Dimensions.getProportionalHeight(15))),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xfff3f3f3),
                      offset: Offset(5, 5),
                      blurRadius: 10)
                ]),
          ),
        ),
      ],
    ));
  }
}
