import 'package:flutter/material.dart';
import 'package:librarium/core/app.dart';
import 'package:librarium/globalVariables.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool("login") == true) {
    isLoggedIn = true;
  }
  else {
    isLoggedIn = false;
  }
  runApp(const MyApp());
}
