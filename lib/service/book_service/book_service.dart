import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../environment/environment.dart';
import '../../model/book.dart';
import '../main/main_service.dart';

class BookService extends MainService {

  Logger logger = Logger();

  static const String saveBookApi = "/private-app-api/save/book";
  static const String findRandomBooksApi = "/private-app-api/find/random/books";

  Future<bool> saveBook(Book book) async {
    String api = "${Environment().apiUrl}$saveBookApi";

    final SharedPreferences prefs = await getPrefs();

    final response = await http.post(
      Uri.parse(api),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Accept": "application/json; charset=UTF-8",
        HttpHeaders.authorizationHeader: prefs.getString("token").toString(),
      },
      body: jsonEncode(book.toJson())
    );
    if (response.statusCode == 200) {
      return bool.tryParse(response.body) ?? false;
    }
    else {
      return throw Exception("Service 'saveBook' failed with statusCode: ${response.statusCode}");
    }
  }

  Future<List<Book>> findRandomBooks() async {
    String api = "${Environment().apiUrl}$findRandomBooksApi";

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
      final List<Book> bookList = List<Book>.from(jsonData.map((x) => Book.fromJson(x)));
      return bookList;
    }
    else {
      return throw Exception("Service 'findRandomBooks' failed with statusCode: ${response.statusCode}");
    }
  }

}
