import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:librarium/model/login.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../environment/environment.dart';
import '../../model/user.dart';

class AuthenticationService {

  Logger logger = Logger();

  static const String registerApi = "/public-app-api/register";
  static const String loginApi = "/public-app-api/login";

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

  Future<User?> login(Login login) async {
    String api = "${Environment().apiUrl}$loginApi";

    final response = await http.post(
        Uri.parse(api),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Accept": "application/json; charset=UTF-8",
        },
        body: jsonEncode(login.toJson())
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        User loggedUser = User.fromJson(jsonDecode(response.body));
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", loggedUser.token ?? "");
        prefs.setString("username", loggedUser.username ?? "");
        prefs.setString("fName", loggedUser.firstName ?? "");
        prefs.setString("lName", loggedUser.lastName ?? "");
        prefs.setBool("login", true);

        return User.fromJson(jsonDecode(response.body));
      }
    }
    else {
      return throw Exception("Service 'login' failed with statusCode: ${response.statusCode}");
    }
  }

}
