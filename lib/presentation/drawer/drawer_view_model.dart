import 'package:flutter/material.dart';
import 'package:librarium/presentation/common/main_view_model.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/route_manager.dart';
import '../common/dialog/log_out_dialog.dart';
import '../common/snack_bar/show_snack_bar.dart';
import '../resources/string_manager.dart';

class DrawerViewModel extends MainViewModel {
  DrawerViewModel(super.context);

  @override
  void start() {
    // TODO: implement start
    readPrefs();
  }

  Logger logger = Logger();

  listenToChanges() {
    notifyListeners();
  }

  String? username;
  String? firstName;
  String? lastName;

  readPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("username");
    firstName = prefs.getString("fName");
    lastName = prefs.getString("lName");
    notifyListeners();
  }

  goDraftView() {
    Navigator.pushNamed(context, AppRoute.draftRoute);
  }

  goAddAuthorView() {
    Navigator.pushNamed(context, AppRoute.addAuthorRoute);
  }

  goLoginView() {
    Navigator.pushNamedAndRemoveUntil(context, AppRoute.loginRoute, (Route route) => false);
  }

  showLogOutDialog() {
    logOutDialog(context, this);
  }

  goBack() {
    Navigator.pop(context);
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    goLoginView();
    showSnackBar(context, AppString.logOutSuccessful);
  }

}