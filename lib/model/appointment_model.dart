import 'package:parcial_two/model/attention_staff_model.dart';
import 'package:parcial_two/model/patient_model.dart';

class Appointment {
  final int appointmentId;
  final DateTime date;
  final String status;
  Patient patient;
  AttentionStaff attentionStaff;

  Appointment(
      {this.appointmentId, this.date, this.status, patient, attentionStaff}) {
    this.patient = new Patient.fromJson(patient);
    this.attentionStaff = (attentionStaff != null)
        ? new AttentionStaff.fromJson(attentionStaff)
        : null;
  }

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      appointmentId: json['appointmentId'],
      status: json['status'],
      date: DateTime.parse(json['date']),
      patient: json['patient'],
      attentionStaff: json['userAttentionStaff'],
    );
  }
}
