import 'package:flutter/material.dart';
import '../components/surah_card.dart';
import '../components/label_card.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/def_appbar.dart';
import '../../providers/services/database_services.dart';
import '../components/skeleton.dart';

class BookmarkListScreen extends StatefulWidget {
  const BookmarkListScreen({super.key});

  @override
  State<BookmarkListScreen> createState() => _BookmarkListScreenState();
}

class _BookmarkListScreenState extends State<BookmarkListScreen> {
  bool _isLoading = true;
  bool _isError = false;
  DatabaseService dbServ = DatabaseService();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List? surahBookmark;
  _getData() async {
    _isLoading = true;
    surahBookmark =
        await dbServ.queryDetail('temporary_surah', 'tipe', 'bookmark');
    setState(() {
      _isLoading = false;
    });
  }

  _deleteData(int? id) async {
    await dbServ.removeTemp(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefAppBar(
          title: Text("Disimpan", style: Styles.titleBarStyle), centered: true),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const LabelCard(text: 'Daftar Surah Disimpan'),
                    verticalSpaceSmall,
                    _isLoading
                        ? Skeleton.shimmerListSurah
                        : SizedBox(
                            child: ListView.builder(
                                itemCount: surahBookmark?.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (_, index) {
                                  return SurahCard(
                                    index: index + 1,
                                    icon: Icons.bookmark_remove_outlined,
                                    namaSurah:
                                        'Surah ${surahBookmark?[index]["surahName"]}',
                                    descSurah:
                                        'Surah ini terdiri atas ${surahBookmark?[index]["totalAyat"]} ayat.',
                                    tooltip: 'Hapus surah dari daftar simpan',
                                    onTap: () {},
                                    onPressBtnIcon: () async {
                                      await _deleteData(
                                          surahBookmark?[index]["id"]);
                                      setState(() {
                                        _getData();
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              Styles.snackBarRemBookmark);
                                    },
                                  );
                                })),
                  ]))),
    );
  }
}
