import 'package:flutter/material.dart';
import '../../core/styles.dart';
import '../../core/ui_helper.dart';

class SurahCard extends StatelessWidget {
  final int index;
  final IconData? icon;
  final String tooltip;
  final String namaSurah;
  final String descSurah;
  final void Function()? onTap;
  final void Function()? onPressBtnIcon;
  const SurahCard(
      {Key? key,
      required this.index,
      required this.icon,
      required this.namaSurah,
      required this.descSurah,
      required this.tooltip,
      required this.onTap,
      this.onPressBtnIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
        child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Material(
                elevation: 1.0,
                color: lightgreenv2,
                borderRadius: BorderRadius.circular(6),
                child: InkWell(
                    splashColor: Colors.amber[400],
                    onTap: this.onTap,
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 70,
                              decoration: const BoxDecoration(
                                  color: darkgreenv1,
                                  borderRadius: BorderRadius.only(
                                      topLeft: (Radius.circular(6)),
                                      bottomLeft: (Radius.circular(6)))),
                              child: Center(
                                  child: Text(
                                '(${index.toString()})',
                                style: Styles.wLarge25,
                              )),
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    this.namaSurah,
                                    style: Styles.gBold17,
                                  ),
                                  Text(
                                    this.descSurah,
                                    style: Styles.gLight13,
                                  )
                                ]),
                            IconButton(
                              tooltip: this.tooltip,
                              padding: EdgeInsets.all(10),
                              onPressed: onPressBtnIcon,
                              icon: Icon(this.icon),
                              color: darkgreenv1,
                              iconSize: 50,
                            )
                          ]),
                    )))));
  }
}
