import 'package:flutter/material.dart';
import 'package:juzamma/ui/components/surah_card.dart';
import '../components/label_card.dart';
import '../../core/ui_helper.dart';
import '../components/def_appbar.dart';

class BookmarkListScreen extends StatefulWidget {
  const BookmarkListScreen({super.key});

  @override
  State<BookmarkListScreen> createState() => _BookmarkListScreenState();
}

class _BookmarkListScreenState extends State<BookmarkListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefAppBar(title: "Disimpan"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    LabelCard(text: 'Daftar Surah Disimpan'),
                    verticalSpaceSmall,
                    SizedBox(
                        child: ListView.builder(
                            itemCount: 10,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              return SurahCard(
                                icon: Icons.bookmark_remove_outlined,
                                namaSurah: 'Surah An-naba',
                                descSurah: 'Surah ini terdiri ata 25 ayat.',
                                tooltip: 'Hapus surah dari daftar simpan',
                              );
                            })),
                  ]))),
    );
  }
}
