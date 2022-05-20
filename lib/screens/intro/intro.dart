import 'package:dapp/controllers/intro_controller.dart';
import 'package:dapp/models/intromodel.dart';
import 'package:dapp/screens/signup/signup_email/signup_email.dart';
import 'package:dapp/utils/dimensions.dart';
import 'package:dapp/widgets/authButton.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController pageController = PageController(viewportFraction: 0.98);

  var _currPageValue = 0.0;
  double _scaleFactor = 1;
  var _height = Dimensions.screenHeight * 0.6;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page as double;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Widget _buildPageItem(int index, IntroModel intromodel) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }

    return Transform(
      transform: matrix,
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                // height: Dimensions.screenHeight * 0.6,
                margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.getProportionalHeight(14)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      Dimensions.getProportionalHeight(5)),
                  image: DecorationImage(
                      image: AssetImage(
                        intromodel.imagePath!,
                      ),
                      fit: BoxFit.contain),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.getProportionalHeight(20)),
              child: Text(intromodel.title!,
                  style: TextStyle(fontSize: 33, fontWeight: FontWeight.w800)),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GetBuilder<IntroControlller>(builder: (ctrl) {
              return Container(
                height: Dimensions.screenHeight * 0.65,
                child: PageView.builder(
                    controller: pageController,
                    itemCount: ctrl.sliderStuffs.length,
                    itemBuilder: (ctx, position) {
                      return _buildPageItem(
                          position, ctrl.sliderStuffs[position]);
                    }),
              );
            }),
            SizedBox(
              height: Dimensions.getProportionalHeight(20),
            ),
            GetBuilder(builder: (IntroControlller intro) {
              return DotsIndicator(
                dotsCount: intro.sliderStuffs.length,
                position: _currPageValue,
                decorator: DotsDecorator(
                  activeColor: Colors.blue,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              );
            }),
            SizedBox(
              height: Dimensions.getProportionalHeight(45),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: OriginalButton(
                text: 'Continue with email',
                color: Colors.white,
                textColor: Colors.lightBlue,
                onPressed: () {
                  Get.to(() => SignupEmailScreen());
                },
              ),
            ),
            SizedBox(
              height: Dimensions.getProportionalHeight(20),
            ),
          ],
        ),
      ),
    );
  }
}
