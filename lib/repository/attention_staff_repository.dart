import 'package:parcial_two/model/attention_staff_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

Future<List<AttentionStaff>> listAttentionStaff(http.Client client) async {
  final response = await http.get(Uri.parse(
      'https://clinicabuendoctor.azurewebsites.net/api/AttentionStaff'));

  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(goToList, response.body);
}

List<AttentionStaff> goToList(String responseBody) {
  final pasar = json.decode(responseBody).cast<Map<String, dynamic>>();
  return pasar
      .map<AttentionStaff>((json) => AttentionStaff.fromJson(json))
      .toList();
}

Future<AttentionStaff> addStaff(AttentionStaff staff) async {
  var url = Uri.parse(
      'https://clinicabuendoctor.azurewebsites.net/api/AttentionStaff');

  Map dataStaff = {
    "attentionId": "${staff.attentionId}",
    "name": "${staff.name}",
    "lastName": "${staff.lastName}",
    "type": "${staff.type}",
    "photo": "${staff.photo}",
    "serviceStatus": "${staff.serviceStatus}",
    "user": {
      "userName": "${staff.user.userName}",
      "password": "${staff.user.password}",
      "status": "${staff.user.status}",
      "role": "${staff.user.role}"
    }
  };

  //encode Map to JSON
  var body = json.encode(dataStaff);
  print(body);

  var response = await http.post(url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'}, body: body);
  // print("${response.statusCode}");
  // print("${response.body}");

  if (response.statusCode == 200) {
    return AttentionStaff.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    throw Exception('Failed to load staff');
  }
}

Future<AttentionStaff> modifyStaff(AttentionStaff staff) async {
  var url = Uri.parse(
      'https://clinicabuendoctor.azurewebsites.net/api/AttentionStaff');

  Map dataStaff = {
    "attentionId": "${staff.attentionId}",
    "name": "${staff.name}",
    "lastName": "${staff.lastName}",
    "type": "${staff.type}",
    "photo": "${staff.photo}",
    "serviceStatus": "${staff.serviceStatus}",
    "user": {
      "userName": "${staff.user.userName}",
      "password": "${staff.user.password}",
      "status": "${staff.user.status}",
      "role": "${staff.user.role}"
    }
  };
  //encode Map to JSON
  var body = json.encode(dataStaff);
  // print(body);

  var response = await http.put(url,
      headers: {"Content-Type": "application/json"}, body: body);
  print(response.body);
  if (response.statusCode == 200) {
    return AttentionStaff.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    throw Exception('Failed to modify staff');
  }
}

Future<AttentionStaff> deleteAttentionStaff(String attentionId) async {
  final http.Response response = await http.delete(
    Uri.parse(
        'https://clinicabuendoctor.azurewebsites.net/api/AttentionStaff/$attentionId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return AttentionStaff.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    throw Exception('Failed to delete Attention Staff' + response.body);
  }
}
