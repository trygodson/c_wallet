import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet/utils/appColors.dart';
import 'package:wallet/widgets/title_text.dart';

class CustomAppBar extends StatelessWidget {
  String? name;
  CustomAppBar({this.name, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(
              "https://jshopping.in/images/detailed/591/ibboll-Fashion-Mens-Optical-Glasses-Frames-Classic-Square-Wrap-Frame-Luxury-Brand-Men-Clear-Eyeglasses-Frame.jpg"),
        ),
        SizedBox(width: 15),
        TitleText(text: "Hello,"),
        Text(' ${name != null ? name.toString().split(' ')[0] : ''}',
            style: GoogleFonts.mulish(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.navyBlue2)),
        Expanded(
          child: SizedBox(),
        ),
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.short_text,
            color: Theme.of(context).iconTheme.color,
          ),
        )
      ],
    );
  }
}
