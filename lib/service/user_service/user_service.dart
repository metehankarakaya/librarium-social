import 'dart:convert';
import 'dart:io';

import 'package:librarium/model/common_model/edit_about_me.dart';
import 'package:librarium/model/common_model/other_user.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../environment/environment.dart';
import '../../model/user.dart';
import '../main/main_service.dart';

class UserService extends MainService {

  Logger logger = Logger();

  static const String findOtherUserDetailApi = "/private-app-api/find/other/user/detail/";
  static const String findUserDetailApi = "/private-app-api/find/user/detail";
  static const String editAboutMeApi = "/private-app-api/edit/about/me";
  static const String findRandomUsersApi = "/private-app-api/find/random/users";
  static const String findUsersByKeywordApi = "/private-app-api/find/users/by/keyword/";

  Future<OtherUser> findOtherUserDetail(String otherUserId) async {
    String api = "${Environment().apiUrl}$findOtherUserDetailApi$otherUserId";

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
      return OtherUser.fromJson(jsonDecode(response.body));
    }
    else {
      return throw Exception("Service 'findOtherUserDetail' failed with statusCode: ${response.statusCode}");
    }
  }


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

  Future<List<User>> findRandomUsers() async {
    String api = "${Environment().apiUrl}$findRandomUsersApi";

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
      final jsonData = jsonDecode(response.body);
      final List<User> userList = List<User>.from(jsonData.map((x) => User.fromJson(x)));
      return userList;
    }
    else {
      return throw Exception("Service 'findRandomUsers' failed with statusCode: ${response.statusCode}");
    }
  }

  Future<List<User>> findUsersByKeyword(String keyword) async {
    String api = "${Environment().apiUrl}$findUsersByKeywordApi$keyword";

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
      final jsonData = jsonDecode(response.body);
      final List<User> foundUserList = List<User>.from(jsonData.map((x) => User.fromJson(x)));
      return foundUserList;
    }
    else {
      return throw Exception("Service 'findUsersByKeyword' failed with statusCode: ${response.statusCode}");
    }
  }

}
