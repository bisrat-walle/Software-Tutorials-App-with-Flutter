import 'dart:async';
import 'package:softwaretutorials/domain/core/models.dart';

import 'local_database.dart';

class UserLocalRepository {
  final dbProvider = TutorialDataProvider.dbProvider;

  //Adds new User records
  Future<int> createUser(User user) async {
    final db = await dbProvider.database;
    var result = db.insert(userTable, user.toJson());
    return result;
  }

  //Get All Users
  //Searches if query string was passed
  Future<List<User>> getAllUsers() async {
    final db = await dbProvider.database;

    final result = await db.query(userTable);
    List<User> users = result.isNotEmpty
        ? result.map((item) => User.fromJson(item)).toList()
        : [];
    return users;
  }

  //Update Todo record
  Future<int> updateTodo(User user) async {
    final db = await dbProvider.database;

    var result = await db.update(userTable, user.toJson(),
        where: "id = ?", whereArgs: [user.id]);

    return result;
  }

  //Delete Todo records
  Future<int> deleteTodo(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(userTable, where: 'id = ?', whereArgs: [id]);

    return result;
  }
}