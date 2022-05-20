import 'package:wallet/utils/dimensions.dart';
import 'package:wallet/utils/global_style.dart';
import 'package:wallet/widgets/customTextField.dart';
import 'package:flutter/material.dart';

class SignupEmailScreen extends StatelessWidget {
  TextEditingController _emailcontroller = TextEditingController();
  SignupEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: Dimensions.screenHeight * 0.4,
            width: double.maxFinite,
            child: Expanded(
              child: Image.asset(
                'assets/image/logo.png',
                width: Dimensions.getProportionalHeight(50),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.getProportionalWidth(20)),
            child: Column(
              children: [
                Text('Whats Your Email Address',
                    style: GlobalStyle.authScreenBold),
                CustomTextField(
                  etEmail: _emailcontroller,
                  labelText: 'Email Address',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
