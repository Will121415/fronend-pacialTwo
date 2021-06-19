import 'package:parcial_two/model/user_model.dart';

class AttentionStaff {
  final String attentionId;
  final String name;
  final String lastName;
  final String type;
  final String photo;
  final String serviceStatus;
  User user;

  AttentionStaff(
      {this.attentionId,
      this.name,
      this.lastName,
      this.type,
      this.photo,
      this.serviceStatus,
      user}) {
    this.user = (user != null) ? new User.fromJson(user) : null;
  }
  factory AttentionStaff.fromJson(Map<String, dynamic> json) {
    return AttentionStaff(
      attentionId: json['attentionId'],
      name: json['name'],
      lastName: json['lastName'],
      type: json['type'],
      photo: json['photo'],
      serviceStatus: json['serviceStatus'],
      user: json['user'],
    );
  }
}
