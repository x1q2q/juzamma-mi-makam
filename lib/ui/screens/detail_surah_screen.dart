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
import 'package:just_audio/just_audio.dart';

class DetailSurahScreen extends StatefulWidget {
  final int suraId;
  final String? surahName;
  final String? totalAyat;
  final bool autoPlay;
  const DetailSurahScreen(
      {super.key,
      required this.suraId,
      this.surahName,
      this.totalAyat,
      this.autoPlay = false});

  @override
  State<DetailSurahScreen> createState() => _DetailSurahScreenState();
}

class _DetailSurahScreenState extends State<DetailSurahScreen> {
  DatabaseService dbServ = DatabaseService();
  bool _isVisibleAudioTabs = false;
  bool _isFavoriteSurah = false;
  bool _isBookmarkedSurah = false;
  bool _isStoredBookmark = false;
  bool _isStoredFavorit = false;

  bool _isLoading = true;
  String ayatOnPlay = "0";
  bool onPause = false;
  bool onPlaySequence = false;
  bool onEndAyat = false;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _getData();
    if (widget.autoPlay) {
      playSequence(widget.suraId.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  List? allAyat;
  List? dataInRaw;
  _getData() async {
    _isLoading = true;
    _isStoredBookmark = await dbServ.isStored('temporary_surah', 'suraId',
        widget.suraId.toString(), 'tipe', 'bookmark');
    _isStoredFavorit = await dbServ.isStored('temporary_surah', 'suraId',
        widget.suraId.toString(), 'tipe', 'favorit');
    allAyat = await dbServ.queryDetail(
        'quran_id', "suraId", widget.suraId.toString());
    setState(() {
      _isLoading = false;
      _isBookmarkedSurah = _isStoredBookmark;
      _isFavoriteSurah = _isStoredFavorit;
    });
  }

  endAyat() async {
    player.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        if (int.parse(widget.totalAyat!) == int.parse(ayatOnPlay)) {
          setState(() {
            _isVisibleAudioTabs = false;
            ayatOnPlay = "0";
          });
        } else {
          setState(() {
            onEndAyat = true;
          });
        }
      }
    });
  }

  playAudio(String? folder, String? file) async {
    await addToRecentplay();
    await player.setAsset("assets/ayat/$folder/$file.mp3");
    setState(() {
      ayatOnPlay = file!;
      _isVisibleAudioTabs = true;
      onPlaySequence = false;
      onPause = false;
      onEndAyat = false;
    });
    await player.play();
    await endAyat();
  }

  playSequence(String? folder) async {
    setState(() {
      _isVisibleAudioTabs = true;
      onPlaySequence = true;
      onEndAyat = false;
    });
    await addToRecentplay();
    int total = int.parse(widget.totalAyat!);
    var audios = <AudioSource>[];
    var list = [for (var i = 0; i <= total; i++) i];

    list.forEach((i) {
      return audios.add(AudioSource.asset("assets/ayat/$folder/$i.mp3"));
    });
    final playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: audios,
    );
    await player.setAudioSource(playlist,
        initialIndex: 0, initialPosition: Duration.zero);

    await player.play();
    if (player.currentIndex == int.parse(widget.totalAyat!)) {
      setState(() {
        ayatOnPlay = "0";
        onEndAyat = true;
      });
    }
  }

  nextAudio(String? folder, String? newFile) async {
    await player.setAsset("assets/ayat/$folder/$newFile.mp3");
    setState(() {
      ayatOnPlay = newFile.toString();
      _isVisibleAudioTabs = true;
      onEndAyat = false;
    });
    await player.play();
    await endAyat();
  }

  prevAudio(String? folder, String? newFile) async {
    await player.setAsset("assets/ayat/$folder/$newFile.mp3");
    setState(() {
      ayatOnPlay = newFile.toString();
      _isVisibleAudioTabs = true;
      onEndAyat = false;
    });
    await player.play();
    await endAyat();
  }

  pauseAudio() async {
    player.pause();
    setState(() {
      onPause = true;
    });
  }

  resumeAudio() async {
    player.play();
    setState(() {
      onPause = false;
    });
  }

  stopAudio() async {
    await player.stop();
    setState(() {
      _isVisibleAudioTabs = false;
      ayatOnPlay = "0";
      onPlaySequence = false;
    });
  }

  addToRecentplay() async {
    Map<String, dynamic> dt = {
      "suraId": widget.suraId.toString(),
      "surahName": widget.surahName,
      "totalAyat": widget.totalAyat,
      "tipe": "recent_play"
    };
    Surah surahData = Surah.fromMap(dt);
    await dbServ.addToRecent(surahData);
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
                      if (_isFavoriteSurah) {
                        await dbServ.removeBySuraId(
                            widget.suraId.toString(), "favorit");
                        await ScaffoldMessenger.of(context)
                            .showSnackBar(Styles.snackBarRemFavorit);
                      } else {
                        Map<String, dynamic> dt = {
                          "suraId": widget.suraId.toString(),
                          "surahName": widget.surahName,
                          "totalAyat": widget.totalAyat,
                          "tipe": "favorit"
                        };
                        Surah surahData = Surah.fromMap(dt);
                        List lastFac = await dbServ.queryDetail(
                            'temporary_surah', 'tipe', 'favorit');
                        if (lastFac.length > 2) {
                          //replace the newes favorit
                          await dbServ.removeBySuraId(
                              lastFac[0]["suraId"].toString(), 'favorit');
                        }
                        await dbServ.addTemp(surahData);
                        await ScaffoldMessenger.of(context)
                            .showSnackBar(Styles.snackBarAddFavorit);
                      }

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
                      if (_isBookmarkedSurah) {
                        await dbServ.removeBySuraId(
                            widget.suraId.toString(), "bookmark");
                        await ScaffoldMessenger.of(context)
                            .showSnackBar(Styles.snackBarRemBookmark);
                      } else {
                        Map<String, dynamic> dt = {
                          "suraId": widget.suraId.toString(),
                          "surahName": widget.surahName,
                          "totalAyat": widget.totalAyat,
                          "tipe": "bookmark"
                        };
                        Surah surahData = Surah.fromMap(dt);
                        await dbServ.addTemp(surahData);
                        await ScaffoldMessenger.of(context)
                            .showSnackBar(Styles.snackBarAddBookmark);
                      }

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
                              onTap: () async {
                                if (!_isVisibleAudioTabs) {
                                  await playSequence(widget.suraId.toString());
                                } else {
                                  await stopAudio();
                                }
                              },
                            ),
                          ],
                        )),
                    Container(
                      width: double.infinity,
                      color: greyv1,
                      padding: EdgeInsets.all(15),
                      child: Center(
                          child: Text(
                              widget.suraId != 1
                                  ? 'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ'
                                  : 'أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ',
                              style: Styles.wLarge23)),
                    ),
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
                                      ayatLatinTeks: allAyat?[index]
                                          ["readText"],
                                      ayatTerjemahan: allAyat?[index]
                                          ["indoText"],
                                      onLongpressed: () async {
                                        await playAudio(
                                            widget.suraId.toString(),
                                            "${index + 1}");
                                      },
                                      ayatke: index + 1,
                                      onIdPlay: ayatOnPlay);
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
                  iconPause: (onPause
                      ? Icons.play_arrow
                      : onEndAyat
                          ? Icons.refresh
                          : Icons.pause),
                  titleSurah: onPlaySequence
                      ? "Surah ${widget.surahName}"
                      : "Surah ${widget.surahName} ($ayatOnPlay/${widget.totalAyat})",
                  previousSurah: () async {
                    if (onPlaySequence) {
                      await player.seekToPrevious();
                    } else {
                      int newFile = int.parse(ayatOnPlay) - 1;
                      if (newFile >= 0) {
                        await prevAudio(
                            widget.suraId.toString(), newFile.toString());
                      } else {
                        null;
                      }
                    }
                  },
                  pauseSurah: () async {
                    if (onPause) {
                      await resumeAudio();
                    } else if (onEndAyat) {
                      if (onPlaySequence) {
                        await playSequence(widget.suraId.toString());
                      } else {
                        await playAudio(widget.suraId.toString(), ayatOnPlay);
                      }
                    } else {
                      await pauseAudio();
                    }
                  },
                  nextSurah: () async {
                    if (onPlaySequence) {
                      await player.seekToNext();
                    } else {
                      int newFile = int.parse(ayatOnPlay) + 1;
                      if (newFile <= int.parse(widget.totalAyat!)) {
                        await nextAudio(
                            widget.suraId.toString(), newFile.toString());
                      } else {
                        null;
                      }
                    }
                  },
                  stopSurah: () {}),
            ),
          )),
    );
  }
}
