import 'dart:async';
import 'package:softwaretutorials/domain/core/models.dart';

import 'local_data_provider.dart';

class UserLocalRepository {
  final dbProvider = LocalDataProvider.dbProvider;

  
  Future<int> createUser(User user) async {
    final db = await dbProvider.database;
    var result = db.insert(userTable, user.toJson());
    return result;
  }

  
  Future<List<User>> getAllUsers() async {
    final db = await dbProvider.database;

    final result = await db.query(userTable);
    List<User> users = result.isNotEmpty
        ? result.map((item) => User.fromJson(item)).toList()
        : [];
    return users;
  }

 
  Future<int> updateUser(User user) async {
    final db = await dbProvider.database;

    var result = await db.update(userTable, user.toJson(),
        where: "id = ?", whereArgs: [user.id]);

    return result;
  }

  Future<User> getUser(String username) async {
    final db = await dbProvider.database;
    var result = await db.query(userTable, where: 'username = ?', whereArgs: [username]);
    final user = User.fromJson(result.first);
    return user;
  }

  
  Future<int> deleteUser(String username) async {
    final db = await dbProvider.database;
    var result = await db.delete(userTable, where: 'username = ?', whereArgs: [username]);
    
    return result;
  }
}