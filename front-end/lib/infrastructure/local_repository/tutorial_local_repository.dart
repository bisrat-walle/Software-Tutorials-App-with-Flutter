import 'dart:async';
import 'package:softwaretutorials/domain/core/models.dart';
import 'package:sqflite/sqflite.dart';

import 'local_data_provider.dart';

class TutorialLocalRepository {
  final dbProvider = LocalDataProvider.dbProvider;
  
  Future<int> createTutorial(Tutorial tutorial) async {
    final db = await dbProvider.database;
    var result = db.insert(tutorialTable, tutorial.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future<List<Tutorial>> getAllTutorials() async {
    final db = await dbProvider.database;

    final result = await db.query(tutorialTable);
    List<Tutorial> tutorials = result.isNotEmpty
        ? result.map((item) => Tutorial.fromSqliteJson(item)).toList()
        : [];
    return tutorials;
  }

  
  Future<int> updateTutorial(Tutorial tutorial) async {
    final db = await dbProvider.database;

    var result = await db.update(tutorialTable, tutorial.toJson(),
        where: "tutorialId = ?", whereArgs: [tutorial.tutorialId]);

    return result;
  }

  Future<int> toggleEnrollement(Tutorial tutorial) async {
    final db = await dbProvider.database;
    var result = await db.update(tutorialTable, tutorial.toJson(),
        where: "tutorialId = ?", whereArgs: [tutorial.tutorialId]);

    return result;
  }

  Future<int> submitProject(Tutorial tutorial) async {
    final db = await dbProvider.database;
    print(tutorial.submittedLink.toString()+"====================");
    var result = await db.update(tutorialTable, tutorial.toJson(),
        where: "tutorialId = ?", whereArgs: [tutorial.tutorialId]);

    return result;
  }

  
  Future<int> deleteTutorial(int tutorialId) async {
    final db = await dbProvider.database;
    var result = await db.delete(tutorialTable, where: 'tutorialId = ?', whereArgs: [tutorialId]);

    return result;
  }

  Future<Tutorial> getTutorial(int tutorialId) async {
    final db = await dbProvider.database;
    var result = await db.query(tutorialTable, where: 'tutorialId = ?', whereArgs: [tutorialId]);

    return Tutorial.fromSqliteJson(result.first);
  }

  Future<int> removeTables() async {
    final db = await dbProvider.database;
    await db.delete(tutorialTable);
    await db.delete(userTable);
    return 1;
  }
}