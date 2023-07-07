import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../environment/environment.dart';
import '../../model/user.dart';

class AuthenticationService {

  Logger logger = Logger();

  static const String registerApi = "/public-app-api/register";

  Future<bool> register(User user) async {
    String api = "${Environment().apiUrl}$registerApi";

    final response = await http.post(
        Uri.parse(api),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Accept": "application/json; charset=UTF-8",
        },
        body: jsonEncode(user.toJson())
    );
    if (response.statusCode == 200) {
      return bool.tryParse(response.body) ?? false;
    }
    else {
      return throw Exception("Service 'register' failed with statusCode: ${response.statusCode}");
    }
  }

}
