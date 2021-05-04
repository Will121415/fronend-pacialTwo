class User {
  final String userName;
  final String password;
  final String status;
  final String role;

  User({this.userName, this.password, this.status, this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userName: json['userName'],
        password: json['password'],
        status: json['status'],
        role: json['role']);
  }
}
