import 'package:get_it/get_it.dart';
import 'package:librarium/service/authentication_service/authentication_service.dart';
import 'package:librarium/service/author_service/author_service.dart';
import 'package:librarium/service/book_service/book_service.dart';
import 'package:librarium/service/dashboard_service/dashboard_service.dart';
import 'package:librarium/service/post_service/post_service.dart';
import 'package:librarium/service/quote_service/quote_service.dart';
import 'package:librarium/service/user_service/user_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<AuthenticationService>(() => AuthenticationService());
  locator.registerLazySingleton<UserService>(() => UserService());
  locator.registerLazySingleton<BookService>(() => BookService());
  locator.registerLazySingleton<AuthorService>(() => AuthorService());
  locator.registerLazySingleton<QuoteService>(() => QuoteService());
  locator.registerLazySingleton<PostService>(() => PostService());
  locator.registerLazySingleton<DashboardService>(() => DashboardService());
}
