class Surah {
  String suraId;
  String tipe;
  String surahName;
  String totalAyat;

  Surah(
      {required this.suraId,
      required this.surahName,
      required this.tipe,
      required this.totalAyat});

  factory Surah.fromMap(Map<String, dynamic> map) {
    return Surah(
        suraId: map['suraId'],
        surahName: map['surahName'],
        tipe: map['tipe'],
        totalAyat: map['totalAyat']);
  }

  Map toJson() {
    return {
      'suraId': suraId,
      'surahName': surahName,
      'tipe': tipe,
      'totalAyat': totalAyat
    };
  }
}
