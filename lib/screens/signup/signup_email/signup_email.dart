import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:wallet/screens/signup/signup_2/signup_2.dart';
import 'package:wallet/utils/dimensions.dart';
import 'package:wallet/utils/global_style.dart';
import 'package:wallet/widgets/authButton.dart';
import 'package:wallet/widgets/customTextField.dart';
import 'package:flutter/material.dart';

class SignupEmailScreen extends StatelessWidget {
  TextEditingController _emailcontroller = TextEditingController();
  SignupEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Dimensions.screenHeight * 0.35,
              width: double.maxFinite,
              child: Expanded(
                child: Image.asset(
                  'assets/image/logo.png',
                  height: Dimensions.screenHeight * 0.30,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.getProportionalWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Whats Your \nEmail Address',
                      style: GlobalStyle.authScreenBold),
                  SizedBox(
                    height: Dimensions.getProportionalHeight(20),
                  ),
                  Text('Email Address', style: GlobalStyle.textInputLabelStyle),
                  CustomTextField(
                    etEmail: _emailcontroller,
                    labelText: 'Email Address',
                  ),
                  SizedBox(
                    height: Dimensions.getProportionalHeight(40),
                  ),
                  OriginalButton(
                    text: 'Continue with email',
                    color: Colors.white,
                    textColor: Colors.lightBlue,
                    onPressed: () {
                      Get.to(() => Signup2());
                    },
                  ),
                  SizedBox(
                    height: Dimensions.getProportionalHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 1,
                        width: Dimensions.screenWidth * 0.27,
                        color: Colors.grey[300],
                      ),
                      Text(
                        'or continue with',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.grey[400]),
                      ),
                      // SizedBox(
                      //   width: Dimensions.getProportionalWidth(10),
                      // ),
                      Container(
                        height: 1,
                        width: Dimensions.screenWidth * 0.27,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.getProportionalHeight(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Dimensions.getProportionalWidth(145),
                        height: Dimensions.getProportionalHeight(60),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.grey[100]!, width: 1),
                        ),
                      ),
                      Container(
                        width: Dimensions.getProportionalWidth(145),
                        height: Dimensions.getProportionalHeight(60),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.grey[100]!, width: 1),
                        ),
                        child: Center(),
                      )
                    ],
                  ),
                  SizedBox(height: Dimensions.getProportionalHeight(20)),
                  Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'Don\'t have an account?  ',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.getProportionalHeight(14),
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = (() => Get.to(() => null,
                                    transition: Transition.fadeIn)),
                              text: 'Sign up',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: Dimensions.getProportionalHeight(14),
                              ),
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
