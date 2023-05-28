class UserModel {
  final String username;
  final String email;
  final String password;
  final String nim;

  UserModel({
    required this.username,
    required this.email,
    required this.password,
    required this.nim,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      nim: json['nim'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'nim': nim,
    };
  }
}