import 'package:flutter/material.dart';
import 'ui_helper.dart';

class Styles {
  static const labelTxtStyle = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w600,
      color: lightgreenv1,
      fontSize: 16);

  static const titleBarStyle = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w900,
      letterSpacing: 1.0,
      color: Colors.white,
      fontSize: 25);

  static const wBold18 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 18);

  static const gBold18 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.bold,
      color: lightgreenv1,
      fontSize: 18);

  static const wRegular14 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.normal,
      color: Colors.white,
      fontSize: 14);

  static const wLargeTitle = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w900,
      color: Colors.white,
      letterSpacing: 0,
      fontSize: 30);

  static const wLarge25 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w900,
      color: Colors.white,
      letterSpacing: 0,
      fontSize: 25);

  static const gLarge25 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w900,
      color: darkgreenv1,
      letterSpacing: 0,
      fontSize: 25);

  static const gLabel20 = TextStyle(
      fontWeight: FontWeight.normal, color: darkgreenv1, fontSize: 20);

  static const gBold17 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w600,
      color: darkgreenv1,
      fontSize: 17);
  static const gLight13 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.normal,
      color: darkgreenv2,
      fontSize: 13);
  static final ButtonStyle elevBtnStyle = ElevatedButton.styleFrom(
      elevation: 0.5,
      backgroundColor: darkgreenv2,
      minimumSize: const Size(110, 55),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      foregroundColor: greyv1,
      textStyle: labelTxtStyle);

  static const headStyle = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: darkgreenv2);

  static const loginStyle = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.white);

  static const boxCardShdStyle = BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 7,
      spreadRadius: 1,
      color: Colors.black12);
  static const whiteStyle = TextStyle(
      fontSize: 15,
      color: Colors.white,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold);

  static const bodyStyle = TextStyle(
      fontFamily: 'Poppins', fontSize: 19, fontWeight: FontWeight.w600);

  static const smallStyle = TextStyle(
      fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w500);
  static const verySmallStyle = TextStyle(
      fontFamily: 'Poppins', fontSize: 10, fontWeight: FontWeight.w500);
}

// by rafiknurf