import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';
import '../models/surah.dart';

class DatabaseService {
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "juzamma.db");

    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      ByteData data = await rootBundle.load(url.join("assets", "juzamma.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE temporary_surah (id INTEGER PRIMARY KEY AUTOINCREMENT, suraId INTEGER, tipe TEXT, surahName TEXT, totalAyat TEXT)');
    // tipe  {'bookmark','favorit','recent_search','recent_play'}
  }

  Future<void> addTemp(Surah? surah) async {
    Database db = await database;
    await db.rawInsert(
        'INSERT INTO temporary_surah(id, suraId, tipe, surahName, totalAyat) VALUES (?, ?, ?, ?, ?)',
        [null, surah?.suraId, surah?.tipe, surah?.surahName, surah?.totalAyat]);
  }

  Future<void> removeTemp(int? id) async {
    Database db = await database;
    await db.rawDelete('DELETE FROM temporary_surah WHERE id="$id"');
  }

  Future<List> queryGroup(String table) async {
    Database db = await database;
    return await db
        .rawQuery('SELECT * FROM "$table" GROUP BY suraId ORDER BY id asc');
  }

  Future<List> queryDetail(String table, String? column, String? value) async {
    Database db = await database;
    return await db.rawQuery(
        'SELECT * FROM "$table" WHERE ${column}="$value" ORDER BY id desc');
  }

  Future<List> queryDetailAnd(String table, String? column1, String? value1,
      String? column2, String? value2) async {
    Database db = await database;
    return await db.rawQuery(
        'SELECT * FROM "$table" WHERE ${column1}="$value1" AND ${column2}="$value2" ORDER BY id desc');
  }

  Future<bool> isStored(String table, String? column1, String? value1,
      String? column2, String? value2) async {
    List data;
    data = await queryDetailAnd(table, column1, value1, column2, value2);
    return (data.isEmpty) ? false : true;
  }

  Future<void> removeBySuraId(String? suraId, String? tipe) async {
    Database db = await database;
    await db.rawDelete(
        'DELETE FROM temporary_surah WHERE suraId="$suraId" AND tipe="$tipe"');
  }

  Future<List> cariSurah(String table, String? keywords) async {
    Database db = await database;
    return await db.rawQuery(
        'SELECT * FROM "$table" WHERE surahName LIKE "%$keywords%" GROUP BY suraId');
  }

  Future<void> addAfterSearch(Surah? surah) async {
    List checkQ;
    checkQ = await queryDetailAnd(
        'temporary_surah', 'suraId', surah!.suraId, 'tipe', 'recent_search');
    if (checkQ.isEmpty) {
      await addTemp(surah);
    }
  }
}
