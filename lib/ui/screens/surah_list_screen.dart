import 'package:flutter/material.dart';
import '../components/surah_card.dart';
import '../components/label_card.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/def_appbar.dart';
import 'detail_surah_screen.dart';
import '../../providers/services/database_services.dart';
import '../components/skeleton.dart';

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({super.key});

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List? allSurah;
  _getData() async {
    DatabaseService dbServ = DatabaseService();
    _isLoading = true;
    allSurah = await dbServ.queryGroup('quran_id');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefAppBar(
          title: Text("Surah", style: Styles.titleBarStyle), centered: true),
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
                    _isLoading
                        ? Skeleton.shimmerListSurah
                        : SizedBox(
                            child: ListView.builder(
                                itemCount: allSurah!.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (_, index) {
                                  return SurahCard(
                                    index: index + 1,
                                    icon: Icons.arrow_forward_ios,
                                    namaSurah:
                                        'Surah ${allSurah?[index]["surahName"]}',
                                    descSurah:
                                        'Surah ini terdiri atas (${allSurah?[index]["totalAyat"]}) ayat.',
                                    tooltip: 'Buka surah Ini',
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailSurahScreen(
                                                    suraId: allSurah?[index]
                                                        ["suraId"],
                                                    surahName: allSurah?[index]
                                                        ["surahName"],
                                                    totalAyat: allSurah?[index]
                                                        ["totalAyat"],
                                                  )))
                                    },
                                  );
                                })),
                  ]))),
    );
  }
}
