class LoginResponse{
    String? username;
    String? accessToken;
    String? role;
    LoginResponse({this.username, this.role, this.accessToken});

    factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      username: json['username'],
      role: json['role'],
      accessToken: json['accessToken']
    );
    }
}