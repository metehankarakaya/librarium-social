import 'package:flutter/material.dart';
import 'package:librarium/presentation/drawer/drawer_view_model.dart';
import 'package:stacked/stacked.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DrawerViewModel>.reactive(
      viewModelBuilder: () => DrawerViewModel(context),
      builder: (context, viewModel, child) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: const Text("LogOut"),
                onTap: () => viewModel.showLogOutDialog(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
