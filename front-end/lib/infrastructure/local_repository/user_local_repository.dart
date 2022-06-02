import 'dart:async';
import 'package:softwaretutorials/domain/models/models.dart';

import 'local_database.dart';

class UserLocalRepository {
  final dbProvider = TutorialDataProvider.dbProvider;

  //Adds new User records
  Future<int> createUser(User user) async {
    final db = await dbProvider.database;
    var result = db.insert(userTable, user.toJson());
    return result;
  }

}