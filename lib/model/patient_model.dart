class Patient {
  final String patientId;
  final String status;
  final String name;
  final String lastName;
  final String photo;
  final String age;
  final String address;
  final String neighborhood;
  final String phone;
  final String city;

  Patient(
      {this.patientId,
      this.status,
      this.name,
      this.lastName,
      this.photo,
      this.age,
      this.address,
      this.neighborhood,
      this.phone,
      this.city});

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
        patientId: json['patientId'],
        status: json['status'],
        name: json['name'],
        lastName: json['lastName'],
        phone: json['phone'],
        age: json['age'],
        address: json['address'],
        neighborhood: json['neighborhood'],
        photo: json['photo'],
        city: json['city']);
  }
}
