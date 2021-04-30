import 'package:parcial_two/model/login_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Login> signIn(Login login) async {
  var url = Uri.parse('https://clinicabuendoctor.azurewebsites.net/api/Login');

  Map data = {
    'userName': '${login.userName}',
    'password': '${login.password}',
  };
  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'}, body: body);
  // print("${response.statusCode}");
  // print("${response.body}");

  if (response.statusCode == 200) {
    return Login.fromJson(jsonDecode(response.body));
  } else {
    return null;
  }
}
