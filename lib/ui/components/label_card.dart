import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';

class LabelCard extends StatelessWidget {
  final String text;
  const LabelCard({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: darkgreenv1, width: 3))),
        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
        child: Text(
          this.text,
          style: Styles.gLabel20,
        ));
  }
}
