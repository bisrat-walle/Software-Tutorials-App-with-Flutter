class User{
	int? id;
    String? username;
	String? fullName;
	String? password;
    String? email;
	String? role;
    User({this.username, this.fullName, this.id, this.email, this.password, this.role});

    factory User.fromJson(Map<String, dynamic?>? json){
        if (json == null){
          return User();
        }
        return User(
            id: json['id'],
            username: json['username'],
            email: json['email'],
            fullName: json['fullName'],
			role: json['role']
        );
    }

}