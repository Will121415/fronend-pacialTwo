class Login {
  final String userName;
  final String password;
  final String status;
  final String role;

  Login({this.userName, this.password, this.status, this.role});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
        userName: json['userName'],
        password: json['password'],
        status: json['status'],
        role: json['role']);
  }
}
