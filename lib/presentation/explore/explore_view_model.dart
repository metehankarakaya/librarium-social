import 'package:logger/logger.dart';

import '../common/main_view_model.dart';

class ExploreViewModel extends MainViewModel {
  ExploreViewModel(super.context);

  @override
  void start() {
    // TODO: implement start
  }

  Logger logger = Logger();

  listenToChanges() {
    notifyListeners();
  }

}
