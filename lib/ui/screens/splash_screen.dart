import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 2),
      () {
        Navigator.pushReplacementNamed(context, '/tab-screen');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkgreenv1,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Center(),
            onCenter(),
            Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'oleh arafiknurf v1.0 2024',
                  style: Styles.gLight13,
                ))
          ],
        ),
      ),
    );
  }

  Widget onCenter() {
    return Column(children: <Widget>[
      Container(
        width: 250,
        height: 250,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: lightgreenv1,
            borderRadius: BorderRadius.all(Radius.circular(300))),
        child: Image.asset(
          'assets/images/logo_cover.png',
        ),
      ),
      verticalSpaceSmall,
      Text('JUZ AMMA APPS', style: Styles.wLarge25),
      verticalSpaceSmall,
      Text("MI PLUS MA'ARIF NU", style: Styles.wRegular14),
      Text("Makam - Rembang - Purbalingga", style: Styles.wRegular14),
    ]);
  }
}
