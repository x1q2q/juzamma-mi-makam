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
      fontWeight: FontWeight.w800,
      letterSpacing: 1.0,
      color: Colors.white,
      fontSize: 23);

  static const wBold18 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 18);

  static const lgBold18 = TextStyle(
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

  static const wLarge23 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w600,
      color: Colors.white,
      fontSize: 23);

  static const gLarge26 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w600,
      color: darkgreenv1,
      fontSize: 26);

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

  static const gItalic17 = TextStyle(
      fontFamily: 'Lato',
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w400,
      color: darkgreenv2,
      fontSize: 17);

  static const gBold16 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w500,
      color: darkgreenv2,
      fontSize: 16);

  static const gLight13 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.normal,
      color: darkgreenv2,
      fontSize: 13);

  static const grRegular14 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.normal,
      color: greyv1,
      fontSize: 14);

  static const wRegular13 = TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w800,
      color: Colors.white,
      fontSize: 13);

  static const boxCardShdStyle = BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 7,
      spreadRadius: 1,
      color: Colors.black12);

  static const snackBarRemBookmark = SnackBar(
    content:
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Icon(Icons.remove_circle_rounded, color: Colors.white),
      Text('Bookmark berhasil dihapus', style: Styles.wRegular14)
    ]),
    backgroundColor: greyv2,
    behavior: SnackBarBehavior.floating,
  );

  static const snackBarRemFavorit = SnackBar(
    content:
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Icon(Icons.remove_circle_rounded, color: Colors.white),
      Text('Surah favorit berhasil dihapus', style: Styles.wRegular14)
    ]),
    backgroundColor: greyv2,
    behavior: SnackBarBehavior.floating,
  );

  static const snackBarAddBookmark = SnackBar(
    content:
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text('Berhasil menambahkan ke bookmark', style: Styles.wRegular14),
      Icon(Icons.check_circle, color: Colors.white),
    ]),
    backgroundColor: darkgreenv1,
    behavior: SnackBarBehavior.floating,
  );

  static const snackBarAddFavorit = SnackBar(
    content:
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text('Berhasil menambahkan ke surah favorit', style: Styles.wRegular14),
      Icon(Icons.check_circle, color: Colors.white),
    ]),
    backgroundColor: darkgreenv1,
    behavior: SnackBarBehavior.floating,
  );
}


// by rafiknurf