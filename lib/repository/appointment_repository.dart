import 'package:parcial_two/model/appointment_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

Future<List<Appointment>> listAppointment(http.Client client) async {
  final response = await http.get(
      Uri.parse('https://clinicabuendoctor.azurewebsites.net/api/Appointment'));

  return compute(goToList, response.body);
}

Future<List<Appointment>> listAppointmentUserNull(http.Client client) async {
  final response = await http.get(Uri.parse(
      'https://clinicabuendoctor.azurewebsites.net/api/Appointment/UserNull'));

  return compute(goToList, response.body);
}

Future<List<Appointment>> listAppointmentUserNoNull(http.Client client) async {
  final response = await http.get(Uri.parse(
      'https://clinicabuendoctor.azurewebsites.net/api/Appointment/UserNoNull'));

  return compute(goToList, response.body);
}

List<Appointment> goToList(String responseBody) {
  final pasar = json.decode(responseBody).cast<Map<String, dynamic>>();

  return pasar.map<Appointment>((json) => Appointment.fromJson(json)).toList();
}

Future<List<Appointment>> findByIdStaff(String attentionId) async {
  final http.Response response = await http.get(
    Uri.parse(
        'https://clinicabuendoctor.azurewebsites.net/api/Appointment/$attentionId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  print(response.body);

  return compute(goToList, response.body);
}

Future<Appointment> changeStatus(int appointmentId, int status) async {
  print(appointmentId);
  print(status);

  var url = Uri.parse(
      'https://clinicabuendoctor.azurewebsites.net/api/Appointment/ChanceState');

  Map data = {"appointmentId": "$appointmentId", "status": "$status"};

  var body = json.encode(data);
  print(body);

  var response = await http.put(url,
      headers: {"Content-Type": "application/json"}, body: body);
  if (response.statusCode == 200) {
    return Appointment.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    throw Exception('Failed to ChangeStatus Appointment');
  }
}

Future<Appointment> addPatient(DateTime date, String idPatiente) async {
  var url =
      Uri.parse('https://clinicabuendoctor.azurewebsites.net/api/Appointment');

  Map data = {"date": "$date", "patientId": "$idPatiente"};

  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'}, body: body);
  // print("${response.statusCode}");
  // print("${response.body}");

  if (response.statusCode == 200) {
    return Appointment.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    throw Exception('Failed to load patient');
  }
}

Future<Appointment> AssignAppointment(
    int appointmentId, String idUserStaff) async {
  final http.Response response = await http.put(
    Uri.parse(
        'https://clinicabuendoctor.azurewebsites.net/api/Appointment/api/Appointment/AssignAppointment?appointmentId=${appointmentId}&IduserStaff=${idUserStaff}'),
    headers: <String, String>{
      'accept': 'text/plain',
    },
  );

  if (response.statusCode == 200) {
    return Appointment.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    throw Exception('Failed to Delete patient' + response.body);
  }
}
