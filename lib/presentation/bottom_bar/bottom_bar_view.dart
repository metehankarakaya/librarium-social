import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:librarium/presentation/bottom_bar/bottom_bar_view_model.dart';
import 'package:librarium/presentation/resources/color_manager.dart';
import 'package:stacked/stacked.dart';

class BottomBarView extends StatefulWidget {
  const BottomBarView({Key? key}) : super(key: key);

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomBarViewModel>.reactive(
      viewModelBuilder: () => BottomBarViewModel(context),
      builder: (context, viewModel, child) => Scaffold(
        body: Center(
          child: viewModel.viewList.elementAt(viewModel.selectedIndex),
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: AppColor.transparent,
            highlightColor: AppColor.transparent,
          ),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: AppColor.indigo400,),
                activeIcon: const Icon(Icons.home, color: AppColor.white,),
                label: "",
                backgroundColor: AppColor.blue900
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.magnifyingGlass, color: AppColor.indigo400,),
                activeIcon: const Icon(FontAwesomeIcons.magnifyingGlass, color: AppColor.white,),
                label: "",
                backgroundColor: AppColor.blue900
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.squarePlus, color: AppColor.indigo400,),
                activeIcon: const Icon(FontAwesomeIcons.squarePlus, color: AppColor.white,),
                label: "",
                backgroundColor: AppColor.blue900
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: AppColor.indigo400,),
                activeIcon: const Icon(Icons.person, color: AppColor.white,),
                label: "",
                backgroundColor: AppColor.blue900
              ),
            ],
            currentIndex: viewModel.selectedIndex,
            onTap: viewModel.onItemTapped,
          ),
        ),
      ),
    );
  }
}
