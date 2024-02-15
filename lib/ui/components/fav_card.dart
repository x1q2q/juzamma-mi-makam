import 'package:flutter/material.dart';
import '../../core/styles.dart';
import '../../core/ui_helper.dart';
import 'svg.dart';

class FavCard extends StatelessWidget {
  final String surahName;
  final Function()? onTap;
  const FavCard({Key? key, required this.surahName, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
        child: Material(
            color: lightgreenv3,
            borderRadius: BorderRadius.circular(15),
            elevation: 0.1,
            child: InkWell(
                splashColor: lightgreenv1,
                onTap: onTap,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Container(
                              child: SVG.favIcon,
                              height: 70,
                              width: 70,
                            ),
                            padding: EdgeInsets.all(0)),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: darkgreenv2,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(0),
                                  bottom: Radius.circular(15))),
                          padding: EdgeInsets.all(6),
                          child: Center(
                              child: Text(
                            surahName,
                            style: Styles.wRegular14,
                          )),
                        )
                      ],
                    )))));
  }
}
