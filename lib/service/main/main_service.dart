import 'package:shared_preferences/shared_preferences.dart';

abstract class MainService {

  Future<SharedPreferences> getPrefs() {
    return SharedPreferences.getInstance();
  }

}
