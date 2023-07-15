import 'package:librarium/model/common_model/other_user.dart';
import 'package:librarium/presentation/common/main_view_model.dart';
import 'package:librarium/presentation/common/snack_bar/show_snack_bar.dart';
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

  bool? isFollow = false;
  bool checkFollowers() {
    isFollow = otherUser.followers?.contains(otherUser.visitorId);
    notifyListeners();
    return isFollow!;
  }

  followOtherUser(String otherUserId) async {
    bool isFollowBool = false;
    isFollowBool = await _userService.followOtherUser(otherUserId);
    if (isFollowBool) {
      findOtherUserDetail(otherUserId);
      showSnackBar(context, "Takip edildi.");
    }
    else {
      showSnackBar(context, "Takip edilemedi.");
    }
  }

  unFollowOtherUser(String otherUserId) async {
    bool isUnFollowBool = false;
    isUnFollowBool = await _userService.unfollowOtherUser(otherUserId);
    if (isUnFollowBool) {
      findOtherUserDetail(otherUserId);
      showSnackBar(context, "Takipten çıkarıldı.");
    }
    else {
      showSnackBar(context, "Takipten çıkarılamadı.");
    }
  }

  OtherUser otherUser = OtherUser();

  findOtherUserDetail(String otherUserId) async {
    otherUser = await _userService.findOtherUserDetail(otherUserId);
    notifyListeners();
    checkFollowers();
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
