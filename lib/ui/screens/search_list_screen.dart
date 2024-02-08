import 'package:flutter/material.dart';
import 'package:juzamma/ui/components/surah_card.dart';
import '../components/label_card.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';

class SearchListScreen extends StatefulWidget {
  const SearchListScreen({super.key});

  @override
  State<SearchListScreen> createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: darkgreenv2,
        elevation: 0.3,
        title: TextField(
          autofocus: true,
          controller: _searchController,
          style: Styles.gBold17,
          cursorColor: darkgreenv1,
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.white,
            filled: true,
            hintText: 'Cari nama surah ...',
            hintStyle: Styles.gBold17,
          ),
          onChanged: (value) {},
        ),
        centerTitle: true,
        leadingWidth: 70,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 35,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    LabelCard(text: 'Riwayat Pencarian'),
                    verticalSpaceSmall,
                    SizedBox(
                        child: ListView.builder(
                            itemCount: 10,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              return SurahCard(
                                icon: Icons.close,
                                namaSurah: 'Surah Al-Falaq',
                                descSurah: 'Surah ini terdiri ata 25 ayat.',
                                tooltip: 'Hapus surah dari riwayat pencarian',
                              );
                            })),
                  ]))),
    ));
  }
}
