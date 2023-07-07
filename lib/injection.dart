import 'package:get_it/get_it.dart';
import 'package:librarium/service/authentication_service/authentication_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<AuthenticationService>(() => AuthenticationService());
}
