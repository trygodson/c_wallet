/*
this is global style
This file is used to styling a whole application
 */

import 'package:flutter/material.dart';

class GlobalStyle {
  static const TextStyle textInputStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16);
  static TextStyle textInputLabelStyle = TextStyle(
      color: Colors.grey.shade600, fontWeight: FontWeight.w600, fontSize: 15);
  static const TextStyle authScreenBold = TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.w800,
    fontSize: 44,
    height: 1.4,
  );
}
