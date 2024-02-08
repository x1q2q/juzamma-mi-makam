import 'package:flutter/material.dart';
import 'package:juzamma/ui/components/surah_card.dart';
import '../components/label_card.dart';
import '../../core/ui_helper.dart';
import '../components/def_appbar.dart';

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({super.key});

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefAppBar(title: "Surah"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    LabelCard(text: 'Daftar Semua Surah'),
                    verticalSpaceSmall,
                    SizedBox(
                        child: ListView.builder(
                            itemCount: 10,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              return SurahCard(
                                icon: Icons.arrow_forward_ios,
                                namaSurah: 'Surah Al-Insyiroh',
                                descSurah: 'Surah ini terdiri ata 30 ayat.',
                                tooltip: 'Buka surah Ini',
                              );
                            })),
                  ]))),
    );
  }
}
