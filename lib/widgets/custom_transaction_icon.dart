import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet/utils/dimensions.dart';

class CustomTransactionIcon extends StatelessWidget {
  IconData icon;
  String text;
  double size;
  GestureTapCallback function;
  CustomTransactionIcon(
      {this.size = 80,
      required this.icon,
      required this.function,
      required this.text,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: function,
          child: Container(
            height: size,
            width: size,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 21, 47, 88),
                borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.getProportionalWidth(30))),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xfff3f3f3),
                      offset: Offset(5, 5),
                      blurRadius: 10)
                ]),
            child: Icon(
              icon,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
        Text(text,
            style: GoogleFonts.mulish(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xff76797e))),
      ],
    );
  }
}
