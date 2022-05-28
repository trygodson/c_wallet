import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:wallet/controllers/usercontroller.dart';
import 'package:wallet/controllers/wallet_creation.dart';
import 'package:wallet/helpers/contractFunction.dart' as ctFunction;
import 'package:wallet/screens/root/wallet/addWallet/addwallet.dart';
import 'package:wallet/utils/appColors.dart';
import 'package:wallet/utils/constraint.dart';
import 'package:wallet/utils/dimensions.dart';
import 'package:wallet/widgets/appbar.dart';
import 'package:wallet/widgets/balance_card.dart';
import 'package:wallet/widgets/bottom_navigation_bar.dart';
import 'package:wallet/widgets/custom_transaction_icon.dart';
import 'package:wallet/widgets/title_text.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Dashboard> {
  String? priviteAddress;
  dynamic balance = 0;
  Web3Client? ethClient;
  Client? httpClient;

  Widget _operationsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        CustomTransactionIcon(icon: Icons.arrow_upward_sharp, text: "Send"),
        CustomTransactionIcon(
            icon: Icons.arrow_downward_sharp, text: "Receive"),
        CustomTransactionIcon(icon: Icons.tag_sharp, text: "Buy"),
        // _icon(Icons.currency_exchange, "Swap"),
      ],
    );
  }

  Widget _transectionList() {
    return Column(
      children: <Widget>[
        _transection("Flight Ticket", "23 Feb 2020"),
        _transection("Electricity Bill", "25 Feb 2020"),
        _transection("Flight Ticket", "03 Mar 2020"),
      ],
    );
  }

  Widget _transection(String text, String time) {
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
        text: text,
        fontSize: 14,
      ),
      subtitle: Text(time),
      trailing: Container(
        height: 30,
        width: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          '-20 MLR',
          style: GoogleFonts.mulish(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.navyBlue2),
        ),
      ),
    );
  }

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infruraUrl, httpClient!);

    super.initState();
    sn();
  }

  sn() async {
    await Get.find<UserController>().getCurrentUserDoc();
    dynamic data = await Get.find<UserController>().currentUserDoc;
    if (data != null) {
      setState(() async {
        priviteAddress = data['privateKey'];
        var temp = EthPrivateKey.fromHex(priviteAddress!);
        var cred = temp.address;

        Get.find<ctFunction.ContractFunctionController>()
            .getBalance(cred, ethClient!);
        balance = Get.find<ctFunction.ContractFunctionController>().balance;
      });
    } else {
      Get.snackbar('Balance Error', 'Data is Null');
    }
  }

  @override
  void didChangeDependencies() {
    sn();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: ((controller) {
      return Scaffold(
        bottomNavigationBar: BottomNavigation(),
        body: controller.loading
            ? Center(
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.black))
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
                                name: controller.currentUserDoc['user_name']),
                            SizedBox(
                              height: 40,
                            ),
                            TitleText(text: "My wallet"),
                            SizedBox(
                              height: 20,
                            ),
                            BalanceCard(balance: balance.toString()),
                            SizedBox(
                              height: 50,
                            ),
                            TitleText(
                              text: "Transactions",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _operationsWidget(),
                            SizedBox(
                              height: 40,
                            ),
                            TitleText(
                              text: "Assets",
                            ),
                            _transectionList(),
                          ],
                        ),
                      ),
                    ),
                  ),
      );
    }));
  }
}
