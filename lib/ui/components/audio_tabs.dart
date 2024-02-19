import 'package:flutter/material.dart';
import '../../core/styles.dart';
import '../../core/ui_helper.dart';

class AudioTabs extends StatelessWidget {
  final String titleSurah;
  final void Function() previousSurah;
  final void Function() nextSurah;
  final void Function() pauseSurah;
  final void Function() stopSurah;
  final IconData iconPause;
  const AudioTabs(
      {Key? key,
      required this.titleSurah,
      required this.previousSurah,
      required this.nextSurah,
      required this.pauseSurah,
      required this.stopSurah,
      required this.iconPause})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      color: darkgreenv2,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(titleSurah, style: Styles.wBold18),
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        iconSize: 25,
                        onPressed: previousSurah,
                        color: greyv1,
                        icon: Icon(Icons.skip_previous)),
                    IconButton(
                        iconSize: 25,
                        color: darkgreenv2,
                        onPressed: pauseSurah,
                        icon: Icon(iconPause)),
                    IconButton(
                        iconSize: 25,
                        color: greyv1,
                        onPressed: nextSurah,
                        icon: Icon(Icons.skip_next))
                  ],
                ))
          ]),
    );
  }
}
