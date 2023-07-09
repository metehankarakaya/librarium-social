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
      viewModelBuilder: () {
        DrawerViewModel viewModel = DrawerViewModel(context);
        viewModel.start();
        return viewModel;
      },
      builder: (context, viewModel, child) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(viewModel.firstName ?? ""),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(viewModel.lastName ?? ""),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          "@${viewModel.username}" ?? "",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text("Add Author"),
                onTap: () => viewModel.showLogOutDialog(),
              ),
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
