import 'package:logger/logger.dart';

import '../../injection.dart';
import '../../model/user.dart';
import '../../service/user_service/user_service.dart';
import '../common/dialog/profile_dialog/addedBooksDialog.dart';
import '../common/dialog/profile_dialog/followersDialog.dart';
import '../common/dialog/profile_dialog/followingsDialog.dart';
import '../common/dialog/profile_dialog/quotesDialog.dart';
import '../common/main_view_model.dart';

class ProfileViewModel extends MainViewModel {
  ProfileViewModel(super.context);

  @override
  void start() {
    // TODO: implement start
    findUserDetail();
  }

  Logger logger = Logger();

  listenToChanges() {
    notifyListeners();
  }

  final UserService _userService = locator<UserService>();

  User user = User();

  findUserDetail() async {
    user = await _userService.findUserDetail();
    notifyListeners();
  }

  goSettingView() {

  }

  showQuotesDialog() {
    quotesDialog(context, this);
  }

  showAddedBooksDialog() {
    addedBooksDialog(context, this);
  }

  showFollowingsDialog() {
    followingsDialog(context, this);
  }

  showFollowersDialog() {
    followersDialog(context, this);
  }

}
