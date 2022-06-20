import 'dart:io';

import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wallet/controllers/sendtokencontroller.dart';
import 'package:wallet/models/tokenmodel.dart';
import 'package:wallet/screens/qrscanner/index.dart';
import 'package:wallet/utils/appColors.dart';
import 'package:wallet/utils/dimensions.dart';
import 'package:wallet/utils/global_style.dart';

class SendTokenScreen extends StatelessWidget {
  SendTokenScreen({Key? key}) : super(key: key);

  TextEditingController _receiverAddressController = TextEditingController();

  TextEditingController _receiverAmountController = TextEditingController();
  String selectedDeployedAddress = '';
  @override
  Widget build(BuildContext context) {
    Get.find<SendTokenController>().getTokenList();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            'Send Token',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        height: Dimensions.screenHeight,
        width: Dimensions.screenWidth,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Container(
                  child: GetBuilder<SendTokenController>(builder: (ctrl) {
                    return DropdownFormField<Map<String, dynamic>>(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 15, top: 20),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: AppColors.navyBlue1)),
                        suffixIcon: Icon(Icons.arrow_drop_down),
                        labelText: "Select Token",
                        labelStyle: TextStyle(
                            height: 0.6,
                            color: AppColors.navyBlue1,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      onChanged: (dynamic str) {
                        selectedDeployedAddress = str['deployedaddress'];
                      },
                      // selectedFn: (dynamic item1, dynamic item2) {
                      //   if (item1 != null && item2 != null) {
                      //     return item1['tokenname'] == item2['tokenname'];
                      //   }
                      //   return false;
                      // },
                      dropdownItemFn: (dynamic item, int position, bool focused,
                              bool selected, Function() onTap) =>
                          ListTile(
                        title: Text(item['tokenname'] ?? ""),
                        subtitle: Text(
                          item['deployedaddress'] ?? '',
                        ),
                        tileColor: focused
                            ? Color.fromARGB(20, 0, 0, 0)
                            : Colors.transparent,
                        onTap: onTap,
                      ),
                      displayItemFn: (dynamic item) => Text(
                        (item ?? {})['tokenname'] ?? '',
                        style: TextStyle(fontSize: 16),
                      ),
                      findFn: (dynamic str) async => ctrl.getTokenList(),
                      filterFn: (dynamic item, str) =>
                          item['tokenname']
                              .toLowerCase()
                              .indexOf(str.toLowerCase()) >=
                          0,
                    );
                  }),
                ),
                SizedBox(
                  height: Dimensions.getProportionalHeight(20),
                ),
                TextField(
                  controller: _receiverAddressController,
                  style: GlobalStyle.textInputStyle,
                  decoration: InputDecoration(
                      filled: true,
                      focusColor: Colors.white,
                      // fillColor: grey,
                      // hoverColor: grey,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      labelText: 'Recipient Address',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)),
                      // labelText: widget.labelText,
                      labelStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          Get.to(
                            () => QrScannerScreen(
                                receiverAddress: _receiverAddressController),
                          );
                        },
                        child: Icon(Icons.qr_code_scanner_outlined),
                      )),
                ),
                SizedBox(
                  height: Dimensions.getProportionalHeight(20),
                ),
                TextField(
                  controller: _receiverAmountController,
                  style: GlobalStyle.textInputStyle,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    focusColor: Colors.white,
                    // fillColor: grey,
                    // hoverColor: grey,
                    labelText: 'Amount',
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2)),
                    // labelText: widget.labelText,
                    labelStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    suffixText: 'ETH',

                    suffixStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: Dimensions.getProportionalHeight(20),
                ),
                GetBuilder<SendTokenController>(builder: (sendCtrl) {
                  return Container(
                    width: double.infinity,
                    height: Dimensions.getProportionalHeight(50),
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedDeployedAddress == '') {
                          Get.snackbar(
                              'Your Token', 'Please select choice of token');
                        } else if (_receiverAmountController.text == '') {
                          Get.snackbar('Amount', 'Amount field is empty');
                        } else if (_receiverAddressController.text == '') {
                          Get.snackbar('Address', 'Address field is empty');
                        } else {
                          sendCtrl.sendtoken(
                              int.parse(_receiverAmountController.text),
                              _receiverAddressController.text,
                              selectedDeployedAddress);
                        }
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
                })
              ],
            )),
      )),
    );
  }
}
