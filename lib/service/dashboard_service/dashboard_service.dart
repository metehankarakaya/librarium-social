import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../environment/environment.dart';
import '../../model/dashboard_item.dart';
import '../main/main_service.dart';

class DashboardService extends MainService {

  Logger logger = Logger();

  static const String findDashboardItemsByUserAndFollowersApi = "/private-app-api/find/dashboard/items/by/user/and/followings";

  Future<List<DashboardItem>> findDashboardItemsByUserAndFollowers(int pageNumber) async {
    String api = "${Environment().apiUrl}$findDashboardItemsByUserAndFollowersApi?pageNumber=$pageNumber&pageSize=10";

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
      final List<DashboardItem> dashboardItemList = List<DashboardItem>.from(jsonData.map((x) => DashboardItem.fromJson(x)));
      return dashboardItemList;
    }
    else {
      return throw Exception("Service 'findDashboardItemsByUserAndFollowers' failed with statusCode: ${response.statusCode}");
    }
  }

}