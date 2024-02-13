import 'package:flutter/material.dart';
import '../../core/styles.dart';
import '../../core/ui_helper.dart';
import '../components/def_appbar.dart';
import '../components/svg.dart';
import '../components/svg_btn_icon.dart';
import '../components/clip_btn.dart';
import '../components/ayat_card.dart';
import '../components/audio_tabs.dart';
import '../../providers/services/database_services.dart';
import '../../providers/models/surah.dart';

class DetailSurahScreen extends StatefulWidget {
  final String? suraId;
  final String? surahName;
  final String? totalAyat;
  const DetailSurahScreen(
      {super.key, this.suraId, this.surahName, this.totalAyat});

  @override
  State<DetailSurahScreen> createState() => _DetailSurahScreenState();
}

class _DetailSurahScreenState extends State<DetailSurahScreen> {
  bool _isVisibleAudioTabs = false;
  bool _isFavoriteSurah = false;
  bool _isBookmarkedSurah = false;

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

  List? allAyat;
  _getData() async {
    DatabaseService dbServ = DatabaseService();
    _isLoading = true;
    allAyat = await dbServ.queryDetail('quran_id', "suraId", widget.suraId);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: DefAppBar(
              title: Text("Surah ${widget.surahName}",
                  style: Styles.titleBarStyle),
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
              actBtn: <Widget>[
                SVGBtnIcon(
                    onTap: () async {
                      final snackBarFav = _isFavoriteSurah
                          ? Styles.snackBarRemFavorit
                          : Styles.snackBarAddFavorit;
                      ScaffoldMessenger.of(context).showSnackBar(snackBarFav);

                      setState(() {
                        _isFavoriteSurah = !_isFavoriteSurah;
                      });
                    },
                    svg: _isFavoriteSurah
                        ? SVG.filledLoveIcon
                        : SVG.outlineLoveIcon,
                    bgColor: Colors.transparent,
                    splashColor: darkgreenv1),
                SVGBtnIcon(
                    onTap: () async {
                      Map<String, dynamic> dt = {
                        "suraId": widget.suraId,
                        "surahName": widget.surahName,
                        "totalAyat": widget.totalAyat,
                        "tipe": "bookmark"
                      };
                      Surah surahData = Surah.fromMap(dt);
                      DatabaseService dbServ = DatabaseService();
                      await dbServ.addBookmark(surahData);
                      final snackBarBook = _isBookmarkedSurah
                          ? Styles.snackBarRemBookmark
                          : Styles.snackBarAddBookmark;
                      ScaffoldMessenger.of(context).showSnackBar(snackBarBook);
                      setState(() {
                        _isBookmarkedSurah = !_isBookmarkedSurah;
                      });
                    },
                    svg: _isBookmarkedSurah
                        ? SVG.filledBookmarkIcon
                        : SVG.outlineBookmarkIcon,
                    bgColor: Colors.transparent,
                    splashColor: darkgreenv1)
              ]),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        color: lightgreenv3,
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Surah ${widget.surahName} (mekkah, ${widget.totalAyat} ayat)',
                              style: Styles.grRegular14,
                            ),
                            ClipBtn(
                              bgColor: _isVisibleAudioTabs ? redv1 : greyv1,
                              widget1: Text(
                                  _isVisibleAudioTabs ? 'stop' : 'putar',
                                  style: Styles.wRegular13),
                              widget2: Icon(
                                _isVisibleAudioTabs
                                    ? Icons.stop_circle_rounded
                                    : Icons.play_arrow,
                                color: Colors.white,
                              ),
                              onTap: () => {
                                setState(() {
                                  _isVisibleAudioTabs = !_isVisibleAudioTabs;
                                })
                              },
                            ),
                          ],
                        )),
                    widget.suraId != '1'
                        ? Container(
                            width: double.infinity,
                            color: greyv1,
                            padding: EdgeInsets.all(15),
                            child: Center(
                                child: Text(
                                    'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ',
                                    style: Styles.wLarge23)),
                          )
                        : Center(),
                    _isLoading
                        ? Column(
                            children: <Widget>[
                              verticalSpaceLarge,
                              Center(
                                  child: CircularProgressIndicator(
                                color: darkgreenv1,
                              )),
                            ],
                          )
                        : SizedBox(
                            child: ListView.builder(
                                itemCount: allAyat?.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (_, index) {
                                  return AyatCard(
                                    ayatTeks: allAyat?[index]["ayahText"],
                                    ayatLatinTeks: allAyat?[index]["readText"],
                                    ayatTerjemahan: allAyat?[index]["indoText"],
                                    onLongpressed: () {
                                      print(allAyat?[index]["readText"]);
                                    },
                                    ayatke: index + 1,
                                  );
                                })),
                  ])),
          bottomNavigationBar: Visibility(
            visible: _isVisibleAudioTabs,
            maintainAnimation: true,
            maintainState: true,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              opacity: _isVisibleAudioTabs ? 1 : 0,
              child: AudioTabs(
                  titleSurah: "Surah Al-Insyiroh (1/34)",
                  previousSurah: () {},
                  pauseSurah: () {},
                  nextSurah: () {},
                  stopSurah: () {}),
            ),
          )),
    );
  }
}
