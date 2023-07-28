import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:librarium/presentation/drawer/drawer_view_model.dart';
import 'package:librarium/presentation/resources/string_manager.dart';
import 'package:stacked/stacked.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
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
              SizedBox(height: size.height/128,),
              SafeArea(
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: viewModel.user.avatar != null
                    ? MemoryImage(viewModel.user.avatar!)
                    : null,
                ),
              ),
              ListTile(
                title: Text("@${viewModel.user.username}"),
                subtitle: Text("${viewModel.user.firstName} ${viewModel.user.lastName}"),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.drafts),
                title: const Text(AppString.draft),
                onTap: () => viewModel.goDraftView(),
              ),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text(AppString.addAuthor),
                onTap: () => viewModel.goAddAuthorView(),
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.arrowRightFromBracket),
                title: const Text(AppString.logOut),
                onTap: () => viewModel.showLogOutDialog(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
