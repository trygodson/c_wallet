import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet/controllers/sendtokencontroller.dart';
import 'package:wallet/utils/appColors.dart';
import 'package:wallet/utils/dimensions.dart';
import 'package:wallet/widgets/normalAppBar.dart';
import 'package:web3dart/web3dart.dart';

class OutgoingTransaction extends StatelessWidget {
  TransactionInformation? transactionInfo;
  OutgoingTransaction({
    required this.transactionInfo,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Uri toLaunch =
        Uri.parse('https://goerli.etherscan.io/tx/${transactionInfo!.hash}');
    return Scaffold(
      appBar: NormalAppBar(
          title: 'Outgoing Transaction', action: true, url: toLaunch),
      body: Container(
        height: Dimensions.screenHeight,
        width: Dimensions.screenWidth,
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.getProportionalWidth(20),
            vertical: Dimensions.getProportionalHeight(20)),
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
                        '-0.3873877ETH',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        '( = US\$ 1567.48)',
                        style:
                            TextStyle(fontSize: 14, color: AppColors.lightGrey),
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
                        'Recipient',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        transactionInfo!.to.toString(),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Crypto ID',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        transactionInfo!.blockNumber.blockNum.toString(),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            "Gas ${transactionInfo!.gas.toString()}",
                            style:
                                TextStyle(fontSize: 14, color: AppColors.grey),
                          ),
                          Text(
                            transactionInfo!.gasPrice.toString(),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nounce',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        transactionInfo!.nonce.toString(),
                        style: TextStyle(fontSize: 14, color: AppColors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
