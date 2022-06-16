/*
this is global style
This file is used to styling a whole application
 */

import 'package:flutter/material.dart';

class GlobalStyle {
  static const TextStyle textInputStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 16);
  static TextStyle textInputLabelStyle = TextStyle(
      color: Colors.grey.shade600, fontWeight: FontWeight.w600, fontSize: 15);
  static TextStyle balancePriceStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30);
  static TextStyle balanceTitlePriceStyle = TextStyle(
      color: Colors.blueGrey, fontWeight: FontWeight.w700, fontSize: 14);
  static TextStyle walletDeposittextStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16);
  static const TextStyle addresstextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      overflow: TextOverflow.ellipsis);
  static const TextStyle addressTitletextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontSize: 22,
      overflow: TextOverflow.ellipsis);
  static const TextStyle authScreenBold = TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.w800,
    fontSize: 44,
    height: 1.4,
  );
}
