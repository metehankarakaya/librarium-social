import 'package:librarium/model/draft.dart';
import 'package:librarium/model/post.dart';
import 'package:librarium/presentation/common/main_view_model.dart';
import 'package:librarium/presentation/common/snack_bar/show_snack_bar.dart';
import 'package:librarium/presentation/resources/string_manager.dart';
import 'package:librarium/service/draft_service/draft_service.dart';
import 'package:logger/logger.dart';

import '../../core/route_manager.dart';
import '../../injection.dart';

class DraftViewModel extends MainViewModel {
  DraftViewModel(super.context);

  @override
  void start() {
    // TODO: implement start
    findMyDraft();
  }

  Logger logger = Logger();

  listenToChanges() {
    notifyListeners();
  }

  goOtherProfile({String otherUserId = ""}) async {
    navigateOtherUserProfileWithParam(context, otherUserId);
  }

  final DraftService _draftService = locator<DraftService>();

  int draftSize = 0;
  Draft draft = Draft();
  List<Post> reversedPostList = [];

  findMyDraft() async {
    draft = await _draftService.findMyDraft();
    draftSize = draft.posts!.length + draft.quotes!.length;
    reversedPostList = List.from(draft.posts!.reversed);
    notifyListeners();
  }

  bool isDeleted = false;
  deletePostInDraft(String tempId) async {
    isDeleted = await _draftService.deletePostInDraft(tempId);
    notifyListeners();
    if (isDeleted) {
      showSnackBar(context, AppString.successfullyDeleted);
      findMyDraft();
    }
  }


}