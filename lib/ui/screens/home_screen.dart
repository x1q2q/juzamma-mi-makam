import 'package:flutter/material.dart';
import '../../core/styles.dart';
import '../components/label_card.dart';
import '../components/fav_card.dart';
import '../../core/ui_helper.dart';
import 'search_list_screen.dart';
import '../../providers/services/database_services.dart';
import 'detail_surah_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseService dbServ = DatabaseService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List? surahFav;
  _getData() async {
    _isLoading = true;
    surahFav = await dbServ.queryDetail('temporary_surah', 'tipe', 'favorit');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSizes = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: darkgreenv1,
      body: ListView(children: <Widget>[
        Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Assalamu'alaikum wr wb, Sahabat",
                        style: Styles.wBold18),
                    Text(
                      '08 Februari 2024',
                      style: Styles.wRegular14,
                    ),
                    verticalSpaceLarge,
                    verticalSpaceMedium,
                    Text("JUZ AMMA", style: Styles.wLargeTitle),
                    Text("MI PLUS REMBANG", style: Styles.wLargeTitle),
                    verticalSpaceSmall,
                    Material(
                        color: darkgreenv2,
                        borderRadius: BorderRadius.circular(15),
                        child: InkWell(
                            splashColor: darkgreenv1,
                            onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SearchListScreen()))
                                },
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: lightgreenv1, width: 0.8)),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.search,
                                      size: 30,
                                      color: lightgreenv1,
                                    ),
                                    Text(
                                      'Cari surah di sini',
                                      style: Styles.lgBold18,
                                    )
                                  ],
                                )))),
                  ],
                )),
              ],
            )),
        Stack(children: [
          Container(
              padding: const EdgeInsets.all(20),
              constraints: BoxConstraints(
                  minHeight: screenSizes.height, maxHeight: double.infinity),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: lightgreenv2,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    verticalSpaceSmall,
                    LabelCard(text: 'Terakhir Diputar'),
                    verticalSpaceXSmall,
                    Container(
                      decoration: const BoxDecoration(
                          color: lightgreenv3,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      height: 100,
                      padding: EdgeInsets.only(right: 10),
                      width: double.infinity,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 70,
                              decoration: const BoxDecoration(
                                  color: darkgreenv1,
                                  borderRadius: BorderRadius.only(
                                      topLeft: (Radius.circular(20)),
                                      bottomLeft: (Radius.circular(20)))),
                              child: Center(
                                  child: Text(
                                '(33)',
                                style: Styles.wLarge25,
                              )),
                            ),
                            Text(
                              'Surah Al-Insyiroh',
                              style: Styles.gLarge25,
                            ),
                            IconButton(
                              onPressed: () async {},
                              icon: Icon(Icons.play_circle_fill),
                              color: darkgreenv2,
                              iconSize: 50,
                            )
                          ]),
                    ),
                    verticalSpaceMedium,
                    LabelCard(
                      text: 'Surah Favorit',
                    ),
                    verticalSpaceXSmall,
                    _isLoading
                        ? Center(
                            child:
                                CircularProgressIndicator(color: darkgreenv1))
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 150,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5),
                            itemCount: surahFav?.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext ctx, index) {
                              return FavCard(
                                  surahName: surahFav?[index]["surahName"],
                                  onTap: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailSurahScreen(
                                                    suraId:
                                                        surahFav![index]
                                                                ["suraId"],
                                                    surahName:
                                                        surahFav?[index]
                                                            ["surahName"],
                                                    totalAyat: surahFav?[index]
                                                        ["totalAyat"])));
                                  });
                            }),
                  ])),
        ]),
      ]),
    );
  }
}
