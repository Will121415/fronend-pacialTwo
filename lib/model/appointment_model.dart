import 'package:parcial_two/model/patient_model.dart';

class Appointment {
  final int appointmentId;
  final String date;
  final String status;
  Patient patient;
  // final UserAttentionStaff;

  Appointment({this.appointmentId, this.date, this.status, patient}) {
    this.patient = new Patient.fromJson(patient);
  }

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
        AppointmentId: json['appointmentId'],
        Status: json['status'],
        Date: DateTime.parse(json['date']),
        patient: json['patient'],
    );
  }
}
