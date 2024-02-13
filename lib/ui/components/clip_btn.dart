import 'package:flutter/material.dart';
import '../../core/styles.dart';
import '../../core/ui_helper.dart';

class ClipBtn extends StatelessWidget {
  final void Function()? onTap;
  final Widget widget1;
  final Widget widget2;
  final Color bgColor;
  const ClipBtn(
      {Key? key,
      this.onTap,
      required this.bgColor,
      required this.widget1,
      required this.widget2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
            splashColor: darkgreenv2,
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
                height: 30,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[widget1, widget2],
                ))));
  }
}
