import 'package:flutter/material.dart';
import 'package:librarium/presentation/common/main_view_model.dart';
import 'package:logger/logger.dart';

import '../home/home_view.dart';

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
    const HomeView(),
    const Center(child: Text("ExploreView"),),
    const Center(child: Text("Add Book"),),
    const Center(child: Text("ProfileView"),),
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }

}