import 'package:flutter/material.dart';
import 'package:librarium/presentation/add_book/add_book_view.dart';
import 'package:librarium/presentation/common/main_view_model.dart';
import 'package:librarium/presentation/explore/explore_view.dart';
import 'package:librarium/presentation/profile/profile_view.dart';
import 'package:logger/logger.dart';

import '../dashboard/dashboard_view.dart';


class BottomBarViewModel extends MainViewModel {
  BottomBarViewModel(super.context);

  @override
  void start() {
    // TODO: implement start
  }

  Logger logger = Logger();

  imChanging() {
    notifyListeners();
  }

  checkAll() {
    return true;
  }

  int selectedIndex = 0;

  final List<Widget> viewList = <Widget>[
    const DashboardView(),
    const ExploreView(),
    const AddBookView(),
    const ProfileView(),
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }

}