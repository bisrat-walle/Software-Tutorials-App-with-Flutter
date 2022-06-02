import 'dart:async';
import 'package:softwaretutorials/domain/models/models.dart';

import 'local_database.dart';

class TutorialLocalRepository {
  final dbProvider = TutorialDataProvider.dbProvider;

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

}