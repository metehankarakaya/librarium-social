import 'package:librarium/presentation/common/main_view_model.dart';
import 'package:logger/logger.dart';

class SettingsViewModel extends MainViewModel {
  SettingsViewModel(super.context);

  @override
  void start() {
    // TODO: implement start
  }

  Logger logger = Logger();

  listenToChanges() {
    notifyListeners();
  }

}