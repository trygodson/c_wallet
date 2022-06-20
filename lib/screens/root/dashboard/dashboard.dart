import 'package:etherscan_api/etherscan_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:wallet/controllers/assetcontroller.dart';
import 'package:wallet/controllers/usercontroller.dart';
import 'package:wallet/controllers/wallet_creation.dart';
import 'package:wallet/helpers/contractFunction.dart' as ctFunction;
import 'package:wallet/helpers/dependencies.dart';
import 'package:wallet/models/assetmodel.dart';
import 'package:wallet/screens/root/wallet/addWallet/addwallet.dart';
import 'package:wallet/screens/sendToken/index.dart';
import 'package:wallet/utils/appColors.dart';
import 'package:wallet/utils/constraint.dart';
import 'package:wallet/utils/dimensions.dart';
import 'package:wallet/widgets/appbar.dart';
import 'package:wallet/widgets/balance_card.dart';
import 'package:wallet/widgets/bottom_navigation_bar.dart';
import 'package:wallet/screens/root/wallet/wallet.dart' as walletscreen;

import 'package:wallet/widgets/custom_transaction_icon.dart';
import 'package:wallet/widgets/receive_token_bottomsheet.dart';
import 'package:wallet/widgets/title_text.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

class Dashboard extends StatelessWidget {
  final Function() notifyParent;
  Dashboard({required this.notifyParent, Key? key}) : super(key: key);
  String? priviteAddress;
  dynamic balance = 0;

  Widget _operationsWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        CustomTransactionIcon(
          icon: Icons.arrow_upward_sharp,
          text: "Send",
          function: () => Get.to(() => SendTokenScreen()),
          // function: () async {
          //   final eth = EtherscanAPI(
          //       apiKey: 'FRZVK2W92YBM4W1DUK1HA2SD6C7287Z4PV', // Api key
          //       chain: EthChain.ropsten, // Network/chain
          //       enableLogs: true // Enable Logging
          //       );

          //   var bal = await eth.balance(
          //     addresses: [deployedcontractAddress],
          //   );
          //   print(bal.toString());
          // },
        ),
        CustomTransactionIcon(
            icon: Icons.arrow_downward_sharp,
            text: "Receive",
            function: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => ReceiveTokenBottomSheet())),
        CustomTransactionIcon(
            icon: Icons.tag_sharp, text: "Buy", function: () {}),
        // _icon(Icons.currency_exchange, "Swap"),
      ],
    );
  }

  Widget _transection(String name, String symbol, String bal, String icon) {
    return GestureDetector(
      onTap: () => Get.to(() => walletscreen.Wallet()),
      child: ListTile(
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
          text: '${name} ${symbol}',
          fontSize: 14,
        ),
        subtitle: Text("23 Feb 2020"),
        trailing: Container(
          height: 30,
          width: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Text(
            '${bal} ${symbol}',
            style: GoogleFonts.mulish(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.navyBlue2),
          ),
        ),
      ),
    );
  }

  // sn() async {
  //   await Get.find<UserController>().getCurrentUserDoc();
  //   dynamic data = await Get.find<UserController>().currentUserDoc;
  //   if (data != null) {
  //     sone() async {
  //       priviteAddress = data['privateKey'];
  //       var temp = EthPrivateKey.fromHex(priviteAddress!);
  //       var cred = temp.address;

  //       Get.find<ctFunction.ContractFunctionController>().getBalance();
  //       balance = Get.find<ctFunction.ContractFunctionController>().balance;
  //     }

  //     sone();
  //     setState(() {});
  //   } else {
  //     Get.snackbar('Balance Error', 'Data is Null');
  //   }
  // }

  // @override
  // void didChangeDependencies() {
  //   sn();
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    sn() async {
      await Get.find<UserController>().getCurrentUserDoc();
      await Get.find<AssetTokenController>().getBalance();
    }

    sn();
    AssetTokenController ctrl = Get.find<AssetTokenController>();
    List<AssetModel> items = [];

    return Scaffold(
        bottomNavigationBar: Container(
          height: Dimensions.getProportionalHeight(70),
        ),
        body: GetBuilder<UserController>(builder: (controller) {
          return controller.loading
              ? Center(
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.black),
                )
              : controller.currentUserDoc == null
                  ? Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            var service = Get.find<WalletAddressController>();
                            final mnemonic = service.generateMnemonic();
                            Get.to(() => AddWallet(
                                  mnemonic: mnemonic,
                                ));
                          },
                          child: Text('Create A Wallet')),
                    )
                  : SafeArea(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 35),
                              CustomAppBar(
                                  name: controller.currentUserDoc['user_name'],
                                  func: notifyParent),
                              SizedBox(
                                height: 40,
                              ),
                              TitleText(text: "My wallet"),
                              SizedBox(
                                height: 20,
                              ),
                              GetBuilder<AssetTokenController>(builder: (ctrl) {
                                return ctrl.loading
                                    ? CircularProgressIndicator()
                                    : BalanceCard(
                                        balance: ctrl.balance.toString());
                              }),
                              SizedBox(
                                height: 50,
                              ),
                              TitleText(
                                text: "Transactions",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              _operationsWidget(context),
                              SizedBox(
                                height: 40,
                              ),
                              TitleText(
                                text: "Assets",
                              ),
                              GetBuilder<AssetTokenController>(
                                builder: (ctrl) {
                                  print(ctrl.assetList.toString());
                                  return ctrl.loading
                                      ? Container(
                                          width: double.maxFinite,
                                          height:
                                              Dimensions.getProportionalHeight(
                                                  75),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      : ctrl.assetList.length == 0
                                          ? Container(
                                              height: Dimensions
                                                  .getProportionalHeight(100),
                                              child: Center(
                                                child: Text('no asset added'),
                                              ),
                                            )
                                          : ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: ctrl.assetList.length,
                                              itemBuilder: (ctx, index) {
                                                return _transection(
                                                  ctrl.assetList[index]
                                                      .tokenName!,
                                                  ctrl.assetList[index]
                                                      .tokenSymbol!,
                                                  ctrl.assetList[index]
                                                      .tokenBalance!,
                                                  ctrl.assetList[index]
                                                      .tokenIcon!,
                                                );
                                              },
                                            );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
        }));
  }
}

// Widget hhb() {
//   return GetBuilder<AssetTokenController>(
//     builder: (ctrl) {
//       print(ctrl.assetList.toString());
//       return ctrl.loading
//           ? Container(
//               width: double.maxFinite,
//               height: Dimensions.getProportionalHeight(75),
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             )
//           : ctrl.assetList.length == 0
//               ? Container(
//                   height: Dimensions.getProportionalHeight(100),
//                   child: Center(
//                     child: Text('no asset added'),
//                   ),
//                 )
//               : ListView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: ctrl.assetList.length,
//                   itemBuilder: (ctx, index) {
//                     return _transection(
//                       ctrl.assetList[index].tokenName!,
//                       ctrl.assetList[index].tokenSymbol!,
//                       ctrl.assetList[index].tokenBalance!,
//                       ctrl.assetList[index].tokenIcon!,
//                     );
//                   },
//                 );
//     },
//   );
// }


                              // Obx(() {
                              //   AssetTokenController ctrl =
                              //       Get.find<AssetTokenController>();
                              //   print("-----> ${ctrl.assetList.value.length}");
                              //   return ListView.builder(
                              //     physics: NeverScrollableScrollPhysics(),
                              //     shrinkWrap: true,
                              //     itemCount: ctrl.assetList.value.length,
                              //     itemBuilder: (ctx, index) {
                              //       return _transection(
                              //         ctrl.assetList.value[index].tokenName!,
                              //         ctrl.assetList.value[index].tokenSymbol!,
                              //         ctrl.assetList.value[index].tokenBalance!,
                              //         ctrl.assetList.value[index].tokenIcon!,
                              //       );
                              //     },
                              //   );
                              // })
