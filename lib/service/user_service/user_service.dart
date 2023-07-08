import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../environment/environment.dart';
import '../../model/user.dart';
import '../main/main_service.dart';

class UserService extends MainService {

  Logger logger = Logger();

  static const String findUserDetailApi = "/private-app-api/find/user/detail";

  Future<User> findUserDetail() async {
    String api = "${Environment().apiUrl}$findUserDetailApi";

    final SharedPreferences prefs = await getPrefs();

    final response = await http.get(
      Uri.parse(api),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Accept": "application/json; charset=UTF-8",
        HttpHeaders.authorizationHeader: prefs.getString("token").toString()
      },
    );
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    else {
      return throw Exception("Service 'findUserDetail' failed with statusCode: ${response.statusCode}");
    }
  }

}