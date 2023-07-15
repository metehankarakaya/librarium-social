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
  static const String findBooksByKeywordApi = "/private-app-api/find/books/by/keyword/";
  static const String findBookDetailsApi = "/private-app-api/find/book/details/";
  static const String findBooksByUserIdApi = "/private-app-api/find/books/by/user/id/";

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

  Future<List<Book>> findBooksByKeyword(String keyword) async {
    String api = "${Environment().apiUrl}$findBooksByKeywordApi$keyword";

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
      final List<Book> foundBookList = List<Book>.from(jsonData.map((x) => Book.fromJson(x)));
      return foundBookList;
    }
    else {
      return throw Exception("Service 'findBooksByKeyword' failed with statusCode: ${response.statusCode}");
    }
  }

  Future<Book> findBookDetails(String bookId) async {
    String api = "${Environment().apiUrl}$findBookDetailsApi$bookId";

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
      return Book.fromJson(jsonDecode(response.body));
    }
    else {
      return throw Exception("Service 'findBookDetails' failed with statusCode: ${response.statusCode}");
    }
  }

  Future<List<Book>> findBooksByUserId(String userId) async {
    String api = "${Environment().apiUrl}$findBooksByUserIdApi$userId";

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
      final List<Book> foundBookList = List<Book>.from(jsonData.map((x) => Book.fromJson(x)));
      return foundBookList;
    }
    else {
      return throw Exception("Service 'findBooksByUserId' failed with statusCode: ${response.statusCode}");
    }
  }

}
