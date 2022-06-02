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

}