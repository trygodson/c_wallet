import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet/controllers/sendtokencontroller.dart';
import 'package:wallet/screens/outgoing_transaction/index.dart';
import 'package:wallet/utils/appColors.dart';
import 'package:wallet/utils/dimensions.dart';
import 'package:wallet/widgets/normalAppBar.dart';
import 'package:web3dart/web3dart.dart';

class SendConfirmation extends StatelessWidget {
  String? from;
  String? to;
  String? amount;
  String? deployedAddress;
  SendConfirmation(
      {required this.to,
      required this.from,
      required this.amount,
      required this.deployedAddress,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar(title: 'Confirm'),
      body: SizedBox(
        height: Dimensions.screenHeight,
        width: Dimensions.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  height: Dimensions.getProportionalHeight(85),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.lightGrey,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '-0.38738773777ETH',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        ' = US\$ 0.48',
                        style: TextStyle(
                            fontSize: 14, color: AppColors.lightBlue2),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: Dimensions.getProportionalHeight(75),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.getProportionalWidth(15)),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.lightGrey,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'From',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        from!,
                        style: TextStyle(fontSize: 14, color: AppColors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: Dimensions.getProportionalHeight(75),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.getProportionalWidth(15)),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.lightGrey,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'To',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        to!,
                        style: TextStyle(fontSize: 14, color: AppColors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: Dimensions.getProportionalHeight(75),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.getProportionalWidth(15)),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.lightGrey,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Network Fee',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '0.003033 ETH',
                            style:
                                TextStyle(fontSize: 14, color: AppColors.grey),
                          ),
                          Text(
                            '(US\$0.00094)',
                            style:
                                TextStyle(fontSize: 14, color: AppColors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: Dimensions.getProportionalHeight(60),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.getProportionalWidth(15)),
                  decoration: const BoxDecoration(color: AppColors.lightGrey),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Max Total',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'US\$0.07',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //button
            GetBuilder<SendTokenController>(
              builder: (sendCtrl) {
                return Container(
                  width: Dimensions.screenWidth * 0.86,
                  height: Dimensions.getProportionalHeight(50),
                  margin: EdgeInsets.only(
                      bottom: Dimensions.getProportionalHeight(15)),
                  child: ElevatedButton(
                    onPressed: () async {
                      await sendCtrl.sendtoken(
                        int.parse(amount!),
                        to!,
                        deployedAddress!,
                      );
                      // Get.to(() => OutgoingTransaction(transactionInfo: txn));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        AppColors.navyBlue1,
                      ),
                    ),
                    child: sendCtrl.loading
                        ? CircularProgressIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Send',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Icon(
                                Icons.send,
                                color: Colors.white,
                              )
                            ],
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
