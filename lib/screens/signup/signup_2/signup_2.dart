import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:wallet/controllers/authController.dart';
import 'package:wallet/screens/root/index.dart';
import 'package:wallet/utils/appColors.dart';
import 'package:wallet/utils/dimensions.dart';
import 'package:wallet/utils/global_style.dart';
import 'package:wallet/widgets/authButton.dart';
import 'package:wallet/widgets/customTextField.dart';
import 'package:flutter/material.dart';

class Signup2 extends StatefulWidget {
  Signup2({Key? key}) : super(key: key);

  @override
  State<Signup2> createState() => _Signup2State();
}

class _Signup2State extends State<Signup2> {
  TextEditingController _namecontroller = TextEditingController();

  TextEditingController _passwordcontroller = TextEditingController();

  dynamic argumentData = Get.arguments;

  // late authcontroller = Get.find<AuthController>();
  bool _obscureText = true;
  IconData _iconVisible = Icons.visibility_off;
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText == true) {
        _iconVisible = Icons.visibility_off;
      } else {
        _iconVisible = Icons.visibility;
      }
    });
  }

  @override
  void dispose() {
    _namecontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

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
                  Text('Let\'s sign you Up!',
                      style: GlobalStyle.authScreenBold),
                  SizedBox(
                    height: Dimensions.getProportionalHeight(20),
                  ),
                  Text('Your Name', style: GlobalStyle.textInputLabelStyle),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty)
                        Get.snackbar('Error', 'Please Enter Name');
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    cursorColor: Colors.blueAccent,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.emailAddress,
                    controller: _namecontroller,
                    style: GlobalStyle.textInputStyle,
                    decoration: InputDecoration(
                      filled: true,
                      focusColor: Colors.white,
                      // fillColor: grey,
                      // hoverColor: grey,
                      fillColor: Colors.white,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)),
                      // labelText: widget.labelText,
                      labelStyle: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.getProportionalHeight(10),
                  ),
                  Text('Your Password', style: GlobalStyle.textInputLabelStyle),
                  TextFormField(
                    obscureText: _obscureText,
                    validator: (value) {
                      if (value!.isEmpty)
                        Get.snackbar('Error', 'Please Enter Password');
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    cursorColor: Colors.blueAccent,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.emailAddress,
                    controller: _passwordcontroller,
                    style: GlobalStyle.textInputStyle,
                    decoration: InputDecoration(
                      filled: true,
                      focusColor: Colors.white,
                      // fillColor: grey,
                      // hoverColor: grey,
                      fillColor: Colors.white,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2)),
                      // labelText: widget.labelText,
                      labelStyle: TextStyle(
                        color: Colors.blue,
                      ),
                      suffixIcon: _obscureText
                          ? IconButton(
                              icon: Icon(_iconVisible,
                                  color: Colors.grey[400], size: 20),
                              onPressed: () {
                                _toggleObscureText();
                              },
                            )
                          : null,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.getProportionalHeight(40),
                  ),
                  OriginalButton(
                    text: 'Login',
                    isIcon: false,
                    textColor: Colors.white,
                    color: AppColors.navyBlue1,
                    onPressed: () {
                      var authcontroller = Get.find<AuthController>();
                      authcontroller
                          .signIn(argumentData[0]['email'],
                              _passwordcontroller.text.trim())
                          .then((value) {
                        print(value);
                      });
                      // Get.to(
                      //   () => RootScreen(),
                      // );
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
                      )
                    ],
                  ),
                  SizedBox(height: Dimensions.getProportionalHeight(20)),
                  Container(
                    width: double.maxFinite,
                    child: Center(
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
                                text: 'Sign in',
                                style: TextStyle(
                                  color: AppColors.navyBlue1,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      Dimensions.getProportionalHeight(14),
                                ),
                              )
                            ]),
                      ),
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
