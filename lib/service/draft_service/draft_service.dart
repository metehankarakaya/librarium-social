import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../environment/environment.dart';
import '../../model/draft.dart';
import '../main/main_service.dart';

class DraftService extends MainService {

  Logger logger = Logger();

  static const String findMyDraftApi = "/private-app-api/find/my/draft";
  static const String deletePostInDraftApi = "/private-app-api/delete/post/in/draft/";

  Future<Draft> findMyDraft() async {
    String api = "${Environment().apiUrl}$findMyDraftApi";

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
      return Draft.fromJson(jsonDecode(response.body));
    }
    else {
      return throw Exception("Service 'findMyDraft' failed with statusCode: ${response.statusCode}");
    }
  }

  Future<bool> deletePostInDraft(String tempId) async {
    String api = "${Environment().apiUrl}$deletePostInDraftApi$tempId";

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
      return bool.tryParse(response.body) ?? false;
    }
    else {
      return throw Exception("Service 'deletePostInDraft' failed with statusCode: ${response.statusCode}");
    }
  }

}