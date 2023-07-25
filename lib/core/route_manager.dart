import 'package:flutter/material.dart';
import 'package:librarium/presentation/add_author/add_author_view.dart';
import 'package:librarium/presentation/add_book/add_book_view.dart';
import 'package:librarium/presentation/add_post/add_post_view.dart';
import 'package:librarium/presentation/add_quote/add_quote_view.dart';
import 'package:librarium/presentation/book_details/book_details_view.dart';
import 'package:librarium/presentation/explore/explore_view.dart';
import 'package:librarium/presentation/other_profile/other_profile_view.dart';
import 'package:librarium/presentation/profile/profile_view.dart';
import 'package:librarium/presentation/settings/settings_view.dart';

import '../presentation/bottom_bar/bottom_bar_view.dart';
import '../presentation/home/home_view.dart';
import '../presentation/login/login_view.dart';
import '../presentation/register/register_view.dart';
import '../presentation/resources/string_manager.dart';

class AppRoute {
  static const String registerRoute = "register";
  static const String loginRoute = "login";
  static const String homeRoute = "home";
  static const String bottomBarRoute = "bottomBar";
  static const String profileRoute = "profile";
  static const String addBookRoute = "addBook";
  static const String addAuthorRoute = "addAuthor";
  static const String settingsRoute = "settings";
  static const String addQuoteRoute = "addQuote";
  static const String addPostRoute = "addPost";
  static const String otherProfileRoute = "otherProfile";
  static const String exploreRoute = "explore";

}

void navigateOtherUserProfileWithParam(BuildContext context, String otherUserId) {
  Navigator.push(context, MaterialPageRoute(builder: (c) => OtherProfileView(otherUserId: otherUserId,)));
}

void navigateBookDetailsWithParam(BuildContext context, String bookId) {
  Navigator.push(context, MaterialPageRoute(builder: (c) => BookDetailsView(bookId: bookId)));
}

class AppRouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoute.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case AppRoute.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case AppRoute.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case AppRoute.bottomBarRoute:
        return MaterialPageRoute(builder: (_) => const BottomBarView());
      case AppRoute.profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileView());
      case AppRoute.addBookRoute:
        return MaterialPageRoute(builder: (_) => const AddBookView());
      case AppRoute.addAuthorRoute:
        return MaterialPageRoute(builder: (_) => const AddAuthorView());
      case AppRoute.settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      case AppRoute.addQuoteRoute:
        return MaterialPageRoute(builder: (_) => const AddQuoteView());
      case AppRoute.exploreRoute:
        return MaterialPageRoute(builder: (_) => const ExploreView());
      case AppRoute.addPostRoute:
        return MaterialPageRoute(builder: (_) => const AddPostView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text(AppString.noRoute),
            centerTitle: true,
          ),
          body: const Center(
            child: Text(AppString.noRouteFound),
          ),
        )
    );
  }

}
