import 'package:librarium/model/common_model/other_user.dart';
import 'package:librarium/presentation/common/main_view_model.dart';
import 'package:logger/logger.dart';

import '../../injection.dart';
import '../../service/user_service/user_service.dart';

class OtherProfileViewModel extends MainViewModel {
  OtherProfileViewModel(super.context);

  @override
  void start() {
    // TODO: implement start
  }

  Logger logger = Logger();

  listenToChanges() {
    notifyListeners();
  }

  final UserService _userService = locator<UserService>();

  OtherUser otherUser = OtherUser();

  findOtherUserDetail(String otherUserId) async {
    otherUser = await _userService.findOtherUserDetail(otherUserId);
    notifyListeners();
  }

  showQuotesDialog() {
    //quotesDialog(context, this);
  }

  showAddedBooksDialog() {
    //addedBooksDialog(context, this);
  }

  showFollowingsDialog() {
    //followingsDialog(context, this);
  }

  showFollowersDialog() {
    //followersDialog(context, this);
  }


}
