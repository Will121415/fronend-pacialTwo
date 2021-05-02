import 'package:parcial_two/model/patient_model.dart';

class Appointment {
  final int AppointmentId;
  final DateTime Date;
  final String Status;
  Patient patient;
  // final UserAttentionStaff;

  Appointment({this.AppointmentId, this.Date, this.Status, patient}) {
    this.patient = new Patient.fromJson(patient);
  }

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
        AppointmentId: json['appointmentId'],
        Status: json['status'],
        Date: json['date'],
        patient: json['patient'],
    );
  }
}
