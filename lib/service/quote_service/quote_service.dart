import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../environment/environment.dart';
import '../../model/quote.dart';
import '../main/main_service.dart';

class QuoteService extends MainService {

  Logger logger = Logger();

  static const String addQuoteApi = "/private-app-api/add/quote";
  static const String findAllQuotesApi = "/private-app-api/find/all/quotes";
  static const String likeQuoteApi = "/private-app-api/like/quote/";
  static const String dislikeQuoteApi = "/private-app-api/dislike/quote/";

  Future<bool> addQuote(Quote quote) async {
    String api = "${Environment().apiUrl}$addQuoteApi";

    final SharedPreferences prefs = await getPrefs();

    final response = await http.post(
      Uri.parse(api),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Accept": "application/json; charset=UTF-8",
        HttpHeaders.authorizationHeader: prefs.getString("token").toString()
      },
      body: jsonEncode(quote.toJson())
    );
    if (response.statusCode == 200) {
      return bool.tryParse(response.body) ?? false;
    }
    else {
      return throw Exception("Service 'addQuote' failed with statusCode: ${response.statusCode}");
    }
  }

  Future<List<Quote>> findAllQuotes() async {
    String api = "${Environment().apiUrl}$findAllQuotesApi";

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
      final List<Quote> quoteList = List<Quote>.from(jsonData.map((x) => Quote.fromJson(x)));
      return quoteList;
    }
    else {
      return throw Exception("Service 'findAllQuotes' failed with statusCode: ${response.statusCode}");
    }
  }

  Future<bool> likeQuote(String quoteId) async {
    String api = "${Environment().apiUrl}$likeQuoteApi$quoteId";

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
      return throw Exception("Service 'likeQuote' failed with statusCode: ${response.statusCode}");
    }
  }

  Future<bool> dislikeQuote(String quoteId) async {
    String api = "${Environment().apiUrl}$dislikeQuoteApi$quoteId";

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
      return throw Exception("Service 'dislikeQuote' failed with statusCode: ${response.statusCode}");
    }
  }

}
