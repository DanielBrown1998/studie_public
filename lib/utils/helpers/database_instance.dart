import 'package:app/features/data/source/database/database.dart';

class DatabaseInstance {
  AppDataBase? database;

  AppDataBase get getdatabase {
    if (database != null) {
      return database!;
    }
    database = AppDataBase();
    return database!;
  }
}
