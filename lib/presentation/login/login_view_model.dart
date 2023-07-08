import 'package:flutter/material.dart';
import 'package:librarium/presentation/common/main_view_model.dart';
import 'package:logger/logger.dart';

import '../../core/route_manager.dart';
import '../../injection.dart';
import '../../model/login.dart';
import '../../model/user.dart';
import '../../service/authentication_service/authentication_service.dart';
import '../common/snack_bar/show_snack_bar.dart';
import '../resources/string_manager.dart';

class LoginViewModel extends MainViewModel {
  LoginViewModel(super.context);

  @override
  void start() {
    // TODO: implement start
  }

  Logger logger = Logger();

  listenToChanges() {
    notifyListeners();
  }

  final regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}$');

  checkAll() {
    if (usernameController.text.length < 8 || usernameController.text.length > 20) {
      return false;
    }
    if (!(regex.hasMatch(passwordController.text))) {
      return false;
    }
    if (usernameController.text == passwordController.text) {
      return false;
    }
    return true;
  }

  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscureText = true;

  changeObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }

  goRegister() {
    Navigator.pushReplacementNamed(context, AppRoute.registerRoute);
  }

  goBottomBar() {
    Navigator.pushReplacementNamed(context, AppRoute.bottomBarRoute);
  }

  Login login = Login();
  User? loggedUser;

  logIn() async {
    login
      ..username = usernameController.text.trim()
      ..password = passwordController.text.trim();
    logger.d(login.toJson());
    loggedUser = await _authenticationService.login(login);
    if (loggedUser != null) {
      logger.w(loggedUser!.toJson());
      goBottomBar();
      showSnackBar(context, AppString.loginSuccessful);
    }
    else {
      showSnackBar(context, AppString.loginFailed);
    }
  }



}
