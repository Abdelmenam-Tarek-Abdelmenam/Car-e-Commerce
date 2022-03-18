import 'package:firebase_database/firebase_database.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseRepository {
  static int lastVersion = 1;
  static Database? database;

  static Future<void> initializeDataBase() async {
    bool dataBaseExists = await databaseExists("data.db");
    if (dataBaseExists) {
      database = await openDatabase("data.db");
    }

    int? databaseVersion = (await database!.getVersion());
    FirebaseDatabase.instance.ref().child("version").get().then((versionRef) {
      lastVersion = versionRef.value as int;
      if (lastVersion != databaseVersion) {
        deleteDatabase("data.db");
        database = null;
      }
    });
  }
}
