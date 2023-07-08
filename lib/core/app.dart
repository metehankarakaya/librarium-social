import 'package:flutter/material.dart';
import 'package:librarium/core/route_manager.dart';
import 'package:librarium/presentation/resources/color_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouteGenerator.getRoute,
      initialRoute: AppRoute.loginRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: AppColor.blue900),
      ),
    );
  }
}
