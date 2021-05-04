import 'package:parcial_two/model/appointment_model.dart';
import 'package:parcial_two/model/patient_model.dart';
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

Future<Appointment> addPatient(DateTime date, String idPatiente) async {
  var url =
      Uri.parse('https://clinicabuendoctor.azurewebsites.net/api/Appointment');

  Map data = {"date": "${date}", "patientId": "${idPatiente}"};

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

// Future<Patient> deletePatient(String patientId) async {
//   print(patientId);
//   final http.Response response = await http.delete(
//     Uri.parse(
//         'https://clinicabuendoctor.azurewebsites.net/api/Patient/$patientId'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//   );

//   if (response.statusCode == 200) {
//     return Patient.fromJson(jsonDecode(response.body));
//   } else {
//     print(response.statusCode);
//     throw Exception('Failed to Delete patient' + response.body);
//   }
// }

// Future<Patient> modifyPatient(Patient patient) async {
//   var url =
//       Uri.parse('https://clinicabuendoctor.azurewebsites.net/api/Patient');

//   Map data = {
//     "patientId": "${patient.patientId}",
//     "name": "${patient.name}",
//     "lastName": "${patient.lastName}",
//     "photo": "${patient.photo}",
//     "age": "${patient.age}",
//     "address": "${patient.address}",
//     "neighborhood": "${patient.neighborhood}",
//     "phone": "${patient.phone}",
//     "city": "${patient.city}",
//     "status": "${patient.status}"
//   };
//   //encode Map to JSON
//   var body = json.encode(data);

//   var response = await http.put(url,
//       headers: {"Content-Type": "application/json"}, body: body);
//   if (response.statusCode == 200) {
//     return Patient.fromJson(jsonDecode(response.body));
//   } else {
//     print(response.statusCode);
//     throw Exception('Failed to modify patient');
//   }
// }