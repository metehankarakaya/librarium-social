import 'dart:convert';
import 'dart:io';

import 'package:librarium/model/common_model/edit_about_me.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../environment/environment.dart';
import '../../model/user.dart';
import '../main/main_service.dart';

class UserService extends MainService {

  Logger logger = Logger();

  static const String findUserDetailApi = "/private-app-api/find/user/detail";
  static const String editAboutMeApi = "/private-app-api/edit/about/me";

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

  Future<bool> editAboutMe(EditAboutMe editAboutMe) async {
    String api = "${Environment().apiUrl}$editAboutMeApi";

    final SharedPreferences prefs = await getPrefs();

    final response = await http.post(
      Uri.parse(api),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Accept": "application/json; charset=UTF-8",
        HttpHeaders.authorizationHeader: prefs.getString("token").toString()
      },
      body: jsonEncode(editAboutMe.toJson())
    );
    if (response.statusCode == 200) {
      return bool.tryParse(response.body) ?? false;
    }
    else {
      return throw Exception("Service 'editAboutMe' failed with statusCode: ${response.statusCode}");
    }
  }

}
