import 'package:equatable/equatable.dart';

class User extends Equatable {
  int? id;
  String? username;
  String? fullName;
  String? password;
  String? email;
  String? role;
  User(
      {this.username,
      this.fullName,
      this.id,
      this.email,
      this.password,
      this.role});

  factory User.fromJson(Map<String, dynamic?>? json) {
    if (json == null) {
      return User();
    }
    return User(
        password: json['password'],
        id: json['id'],
        username: json['username'],
        email: json['email'],
        fullName: json['fullName'],
        role: json['role']);
  }

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "username": this.username,
        "email": this.email,
        "fullName": this.fullName,
        "role": this.role
      };

  @override
  // TODO: implement props
  List<Object?> get props => [username];
}
