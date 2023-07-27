import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../environment/environment.dart';
import '../../model/post.dart';
import '../main/main_service.dart';

class PostService extends MainService {

  Logger logger = Logger();

  static const String addPostApi = "/private-app-api/add/post";
  static const String addPostToDraftApi = "/private-app-api/add/post/to/draft";

  Future<bool> addPost(Post post) async {
    String api = "${Environment().apiUrl}$addPostApi";

    final SharedPreferences prefs = await getPrefs();

    final response = await http.post(
      Uri.parse(api),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Accept": "application/json; charset=UTF-8",
        HttpHeaders.authorizationHeader: prefs.getString("token").toString()
      },
      body: jsonEncode(post.toJson())
    );
    if (response.statusCode == 200) {
      return bool.tryParse(response.body) ?? false;
    }
    else {
      return throw Exception("Service 'addPost' failed with statusCode: ${response.statusCode}");
    }
  }

  Future<bool> addPostToDraft(Post post) async {
    String api = "${Environment().apiUrl}$addPostToDraftApi";

    final SharedPreferences prefs = await getPrefs();

    final response = await http.post(
      Uri.parse(api),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Accept": "application/json; charset=UTF-8",
        HttpHeaders.authorizationHeader: prefs.getString("token").toString()
      },
      body: jsonEncode(post.toJson())
    );
    if (response.statusCode == 200) {
      return bool.tryParse(response.body) ?? false;
    }
    else {
      return throw Exception("Service 'addPostToDraft' failed with statusCode: ${response.statusCode}");
    }
  }

}