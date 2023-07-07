import 'package:flutter/material.dart';

import '../presentation/login/login_view.dart';
import '../presentation/register/register_view.dart';
import '../presentation/resources/string_manager.dart';

class AppRoute {
  static const String registerRoute = "register";
  static const String loginRoute = "login";

}

class AppRouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoute.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case AppRoute.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
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
