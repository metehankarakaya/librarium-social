import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../environment/environment.dart';
import '../../model/author.dart';
import '../main/main_service.dart';

class AuthorService extends MainService {

  Logger logger = Logger();

  static const String addAuthorApi = "/private-app-api/add/author";
  static const String findAllAuthorsApi = "/private-app-api/find/all/authors";

  Future<bool> addAuthor(Author author) async {
    String api = "${Environment().apiUrl}$addAuthorApi";

    final SharedPreferences prefs = await getPrefs();

    final response = await http.post(
      Uri.parse(api),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Accept": "application/json; charset=UTF-8",
        HttpHeaders.authorizationHeader: prefs.getString("token").toString(),
      },
      body: jsonEncode(author.toJson())
    );
    if (response.statusCode == 200) {
      return bool.tryParse(response.body) ?? false;
    }
    else {
      return throw Exception("Service 'addAuthor' failed with statusCode: ${response.statusCode}");
    }
  }

  Future<List<Author>> findAllAuthors() async {
    String api = "${Environment().apiUrl}$findAllAuthorsApi";

    final SharedPreferences prefs = await getPrefs();

    final response = await http.get(
      Uri.parse(api),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Accept": "application/json; charset=UTF-8",
        HttpHeaders.authorizationHeader: prefs.getString("token").toString(),
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<Author> authorList = List<Author>.from(jsonData.map((x) => Author.fromJson(x)));
      return authorList;
    }
    else {
      return throw Exception("Service 'findAllAuthors' failed with statusCode: ${response.statusCode}");
    }
  }

}
