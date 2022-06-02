import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final tutorialTable = 'tutorial';
final userTable = 'user';


class TutorialDataProvider {
  static final TutorialDataProvider dbProvider = TutorialDataProvider();
  late Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }
  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "tutorial.db");
    var database = await openDatabase(path,
        version: 1, onCreate: initDB);
    return database;
  }
        
        
  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $tutorialTable ("
        "tutorialId INTEGER PRIMARY KEY, "
        "title TEXT, "
        "content TEXT, "
        "submittedLInk TEXT, "
        "instructor TEXT, "
        "project TEXT, "
        /*SQLITE doesn't have boolean type
        so we store isDone as integer where 0 is false
        and 1 is true*/
        "enrolled INTEGER, "
        "enrollementCount INTEGER, "
        ")");
    await database.execute("CREATE TABLE $userTable ("
        "id INTEGER PRIMARY KEY, "
        "username TEXT, "
        "email TEXT, "
        "fullName TEXT, "
        "instructor TEXT, "
        "role TEXT, "
        ")");
  }
}