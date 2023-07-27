import 'package:librarium/model/draft.dart';
import 'package:librarium/presentation/common/main_view_model.dart';
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

  Draft draft = Draft();

  findMyDraft() async {
    draft = await _draftService.findMyDraft();
    notifyListeners();
  }


}