import 'package:flutter/cupertino.dart';
import 'package:librarium/model/user.dart';
import 'package:librarium/presentation/common/main_view_model.dart';
import 'package:librarium/service/user_service/user_service.dart';
import 'package:logger/logger.dart';

import '../../../core/route_manager.dart';
import '../../../injection.dart';
import '../../common/dialog/rules_dialog/show_search_keyword_rules_dialog.dart';

class UserSearchViewModel extends MainViewModel {
  UserSearchViewModel(super.context);

  @override
  void start() {
    // TODO: implement start
    findRandomUsers();
  }

  Logger logger = Logger();

  listenToChanges() {
    notifyListeners();
  }

  final UserService _userService = locator<UserService>();

  TextEditingController usernameController = TextEditingController();

  showSearchUserRules() {
    showSearchKeywordRulesDialog(context);
  }

  List<User> foundUsers = [];
  findUsersByKeyword(String keyword) async {
    foundUsers = await _userService.findUsersByKeyword(keyword);
    notifyListeners();
  }

  List<User> randomUsers = [];

  findRandomUsers() async {
    randomUsers = await _userService.findRandomUsers();
    notifyListeners();
  }

  goOtherProfile({String otherUserId = ""}) async {
    navigateOtherUserProfileWithParam(context, otherUserId);
  }

}
