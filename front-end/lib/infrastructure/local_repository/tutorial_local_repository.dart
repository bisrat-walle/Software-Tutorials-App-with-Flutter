import 'dart:async';
import 'package:softwaretutorials/domain/core/models.dart';

import 'local_data_provider.dart';

class TutorialLocalRepository {
  final dbProvider = LocalDataProvider.dbProvider;

  //Adds new Tutorial records
  Future<int> createTutorial(Tutorial tutorial) async {
    final db = await dbProvider.database;
    var result = db.insert(tutorialTable, tutorial.toJson());
    return result;
  }

  //Get All Tutorial items
  //Searches if query string was passed
  Future<List<Tutorial>> getAllTutorials() async {
    final db = await dbProvider.database;

    final result = await db.query(tutorialTable);
    List<Tutorial> tutorials = result.isNotEmpty
        ? result.map((item) => Tutorial.fromJson(item)).toList()
        : [];
    return tutorials;
  }

  //Update Todo record
  Future<int> updateTutorial(Tutorial tutorial) async {
    final db = await dbProvider.database;

    var result = await db.update(tutorialTable, tutorial.toJson(),
        where: "tutorialId = ?", whereArgs: [tutorial.tutorialId]);

    return result;
  }

  //Delete Todo records
  Future<int> deleteTutorial(int tutorialId) async {
    final db = await dbProvider.database;
    var result = await db.delete(tutorialTable, where: 'tutorialId = ?', whereArgs: [tutorialId]);

    return result;
  }
}