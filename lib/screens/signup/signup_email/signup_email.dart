import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:wallet/controllers/authController.dart';
import 'package:wallet/screens/root/index.dart';
import 'package:wallet/screens/signup/signup_2/signup_2.dart';
import 'package:wallet/utils/appColors.dart';
import 'package:wallet/utils/dimensions.dart';
import 'package:wallet/utils/global_style.dart';
import 'package:wallet/widgets/authButton.dart';
import 'package:wallet/widgets/customTextField.dart';
import 'package:flutter/material.dart';

class SignupEmailScreen extends StatefulWidget {
  SignupEmailScreen({Key? key}) : super(key: key);

  @override
  State<SignupEmailScreen> createState() => _SignupEmailScreenState();
}

class _SignupEmailScreenState extends State<SignupEmailScreen> {
  TextEditingController _emailcontroller = TextEditingController();
  IconData _iconVisible = Icons.visibility_off;

  @override
  void dispose() {
    _emailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (controller) {
          return controller.loading
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.black,
                  ),
                )
              : SingleChildScrollView(
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
                            Text('Email Address',
                                style: GlobalStyle.textInputLabelStyle),
                            TextFormField(
                              // validator: (value) {
                              //   if (value!.isEmpty)
                              //     Get.snackbar('Error', 'Please Enter Email');
                              //   ;
                              //   if (!value.contains('@'))
                              //     Get.snackbar('Error', 'Email Invalid');
                              //   ;
                              //   return null;
                              // },
                              textInputAction: TextInputAction.next,
                              cursorColor: Colors.blueAccent,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailcontroller,
                              style: GlobalStyle.textInputStyle,
                              decoration: InputDecoration(
                                filled: true,
                                focusColor: Colors.white,
                                // fillColor: grey,
                                // hoverColor: grey,
                                fillColor: Colors.white,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2)),
                                // labelText: widget.labelText,
                                labelStyle: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.getProportionalHeight(40),
                            ),
                            OriginalButton(
                              text: 'Continue with email',
                              textColor: Colors.white,
                              color: AppColors.navyBlue1,
                              onPressed: () {
                                if (_emailcontroller.text.isNotEmpty) {
                                  if (!_emailcontroller.text.contains('@')) {
                                    Get.snackbar('Error', 'Email Invalid');
                                  } else {
                                    Get.to(() => Signup2(), arguments: [
                                      {'email': _emailcontroller.text.trim()}
                                    ]);
                                  }
                                } else {
                                  Get.snackbar('Error', 'Email Required');
                                }
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
                            SizedBox(
                                height: Dimensions.getProportionalHeight(20)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await Get.find<AuthController>()
                                        .googleLogin();
                                    if (Get.find<AuthController>().user !=
                                        null) {
                                      Get.offAll(RootScreen());
                                    }
                                    ;
                                  },
                                  child: Container(
                                    width: Dimensions.getProportionalWidth(145),
                                    height:
                                        Dimensions.getProportionalHeight(60),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.grey[100]!, width: 1),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Goolge',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: Dimensions.getProportionalWidth(145),
                                  height: Dimensions.getProportionalHeight(60),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.grey[100]!, width: 1),
                                  ),
                                  child: Center(),
                                )
                              ],
                            ),
                            SizedBox(
                                height: Dimensions.getProportionalHeight(20)),
                            Center(
                              child: RichText(
                                text: TextSpan(
                                    text: 'Don\'t have an account?  ',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize:
                                          Dimensions.getProportionalHeight(14),
                                    ),
                                    children: [
                                      TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = (() => Get.to(() => null,
                                              transition: Transition.fadeIn)),
                                        text: 'Sign up',
                                        style: TextStyle(
                                          color: AppColors.navyBlue1,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              Dimensions.getProportionalHeight(
                                                  14),
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
                );
        }));
  }
}
