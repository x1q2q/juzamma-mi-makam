import 'package:flutter/material.dart';
import '../components/surah_card.dart';
import '../components/label_card.dart';
import '../components/def_appbar.dart';
import '../components/skeleton.dart';
import '../components/empty_box.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../../providers/services/database_services.dart';
import 'detail_surah_screen.dart';
import '../../providers/models/surah.dart';

class SearchListScreen extends StatefulWidget {
  const SearchListScreen({super.key});

  @override
  State<SearchListScreen> createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {
  DatabaseService dbServ = DatabaseService();
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  bool _isOnSearching = false;
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

  List? surahRecent;
  _getData() async {
    _isLoading = true;
    surahRecent =
        await dbServ.queryDetail('temporary_surah', 'tipe', 'recent_search');
    setState(() {
      _isLoading = false;
    });
  }

  _deleteData(int? id) async {
    await dbServ.removeTemp(id);
  }

  List? filteredSearch;
  _cariData(String? keyword) async {
    _isLoading = true;
    filteredSearch = await dbServ.cariSurah('quran_id', keyword);
    setState(() {
      _isLoading = false;
      _isOnSearching = true;
      surahRecent = filteredSearch;
    });
  }

  _gotoDetail(BuildContext context, Map<String, dynamic> dt) async {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailSurahScreen(
                suraId: int.parse(dt["suraId"]),
                surahName: dt["surahName"],
                totalAyat: dt["totalAyat"])));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: DefAppBar(
          centered: true,
          title: TextField(
            autofocus: true,
            controller: _searchController,
            style: Styles.gBold17,
            cursorColor: darkgreenv1,
            decoration: const InputDecoration(
              border: InputBorder.none,
              fillColor: Colors.white,
              filled: true,
              hintText: 'Cari nama surah ...',
              hintStyle: Styles.gBold17,
            ),
            onSubmitted: (value) async {
              await _cariData(value);
            },
          ),
          leadingWidth: 70,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 35,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _isOnSearching
                        ? LabelCard(text: 'Hasil Pencarian')
                        : LabelCard(text: 'Riwayat Pencarian'),
                    verticalSpaceSmall,
                    _isLoading
                        ? Skeleton.shimmerListSurah
                        : surahRecent!.isEmpty
                            ? const EmptyBox()
                            : SizedBox(
                                child: ListView.builder(
                                    itemCount: surahRecent?.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, index) {
                                      Map<String, dynamic> resultSearch = {
                                        "suraId": surahRecent?[index]["suraId"]
                                            .toString(),
                                        "surahName": surahRecent?[index]
                                            ["surahName"],
                                        "totalAyat": surahRecent?[index]
                                            ["totalAyat"],
                                        "tipe": "recent_search"
                                      };
                                      return SurahCard(
                                        bgColor: _isOnSearching
                                            ? Colors.amber[100]
                                            : Colors.white,
                                        index: index + 1,
                                        icon: _isOnSearching
                                            ? Icons.arrow_forward_ios
                                            : Icons.close,
                                        namaSurah:
                                            'Surah ${surahRecent?[index]["surahName"]}',
                                        descSurah:
                                            'Surah ini terdiri atas ${surahRecent?[index]["totalAyat"]} ayat.',
                                        tooltip:
                                            'Hapus surah dari riwayat pencarian',
                                        onTap: () async {
                                          if (_isOnSearching) {
                                            Surah filteredSurah =
                                                Surah.fromMap(resultSearch);
                                            await dbServ
                                                .addAfterSearch(filteredSurah);
                                          }
                                          await _gotoDetail(
                                              context, resultSearch);
                                        },
                                        onPressBtnIcon: () async {
                                          if (_isOnSearching) {
                                            Surah filteredSurah =
                                                Surah.fromMap(resultSearch);
                                            await dbServ
                                                .addAfterSearch(filteredSurah);
                                            await _gotoDetail(
                                                context, resultSearch);
                                          } else {
                                            await _deleteData(
                                                surahRecent?[index]["id"]);
                                            setState(() {
                                              _getData();
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                                    Styles.snackBarRemRecentS);
                                          }
                                        },
                                      );
                                    })),
                  ]))),
    ));
  }
}
