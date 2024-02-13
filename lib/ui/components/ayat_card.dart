import 'package:flutter/material.dart';
import '../../core/styles.dart';
import '../../core/ui_helper.dart';
import 'svg.dart';

class AyatCard extends StatelessWidget {
  final String ayatTeks;
  final String ayatLatinTeks;
  final String ayatTerjemahan;
  final int ayatke;
  final void Function()? onLongpressed;

  const AyatCard(
      {Key? key,
      required this.ayatke,
      required this.ayatTeks,
      required this.ayatLatinTeks,
      required this.ayatTerjemahan,
      required this.onLongpressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
        child: Material(
            elevation: 2.0,
            color: ayatke % 2 == 0 ? lightgreenv3 : Colors.white,
            child: InkWell(
                splashColor: lightgreenv2,
                highlightColor: Colors.amberAccent[100],
                onLongPress: onLongpressed,
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                        child: SVG.bingkaiAyatIcon,
                                        width: 50,
                                        height: 50),
                                    Positioned(
                                        child: Text(ayatke.toString(),
                                            style: Styles.gBold17))
                                  ],
                                ),
                                Expanded(
                                    child: Text(
                                  ayatTeks,
                                  style: Styles.gLarge26,
                                  textAlign: TextAlign.right,
                                ))
                              ]),
                          verticalSpaceSmall,
                          Text(ayatLatinTeks,
                              style: const TextStyle(
                                  color: darkgreenv2,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  decoration: TextDecoration.underline,
                                  decorationColor: darkgreenv2)),
                          verticalSpaceXSmall,
                          Text(
                            ayatTerjemahan,
                            style: Styles.gBold16,
                            textAlign: TextAlign.justify,
                          )
                        ])))));
  }
}
