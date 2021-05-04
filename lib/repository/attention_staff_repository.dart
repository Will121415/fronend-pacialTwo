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
