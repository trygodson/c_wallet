import 'package:wallet/utils/dimensions.dart';
import 'package:flutter/material.dart';

class OriginalButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  bool isIcon;
  final Color textColor;

  OriginalButton(
      {Key? key,
      this.isIcon = true,
      required this.text,
      required this.onPressed,
      required this.color,
      required this.textColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: double.infinity,
      child: Center(
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            height: Dimensions.getProportionalHeight(60),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(isIcon ? Icons.mail_rounded : null, color: Colors.white),
                  SizedBox(
                      width: Dimensions.getProportionalWidth(isIcon ? 15 : 0)),
                  Text(
                    text,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
