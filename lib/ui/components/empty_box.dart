import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';

class EmptyBox extends StatelessWidget {
  const EmptyBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
        child: Container(
      child: Center(
          child: Text(
        'Belum ada data',
        style: Styles.gItalic17,
      )),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
              color: darkgreenv2, width: 1, style: BorderStyle.solid)),
    ));
  }
}
