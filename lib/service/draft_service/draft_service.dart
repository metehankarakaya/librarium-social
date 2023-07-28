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
  static const String deleteQuoteInDraftApi = "/private-app-api/delete/quote/in/draft/";
  static const String sharePostInDraftApi = "/private-app-api/share/post/in/draft/";
  static const String shareQuoteInDraftApi = "/private-app-api/share/quote/in/draft/";

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

  Future<bool> sharePostInDraft(String tempId) async {
    String api = "${Environment().apiUrl}$sharePostInDraftApi$tempId";

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
      return throw Exception("Service 'sharePostInDraft' failed with statusCode: ${response.statusCode}");
    }
  }

  Future<bool> deleteQuoteInDraft(String tempId) async {
    String api = "${Environment().apiUrl}$deleteQuoteInDraftApi$tempId";

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
      return throw Exception("Service 'deleteQuoteInDraft' failed with statusCode: ${response.statusCode}");
    }
  }

  Future<bool> shareQuoteInDraft(String tempId) async {
    String api = "${Environment().apiUrl}$shareQuoteInDraftApi$tempId";

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
      return throw Exception("Service 'shareQuoteInDraft' failed with statusCode: ${response.statusCode}");
    }
  }

}