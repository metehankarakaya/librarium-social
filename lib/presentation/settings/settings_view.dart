import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:librarium/presentation/settings/settings_view_model.dart';
import 'package:stacked/stacked.dart';

import '../resources/color_manager.dart';
import '../resources/string_manager.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewModelState();
}

class _SettingsViewModelState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(context),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: AppBar(
          title: const Text("Settings View"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            splashRadius: 20,
            icon: const Icon(Icons.arrow_back_ios),
          ),
          actions: [
            IconButton(
              onPressed: () {

              },
              splashRadius: 20,
              icon: const Icon(FontAwesomeIcons.solidMoon),
            )
          ],
        ),
        body: SingleChildScrollView(
          primary: false,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Column(
              children: [
                ListTile(
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  title: const Text(AppString.notifications),
                  onTap: () {

                  },
                ),
                const Divider(),
                const ListTile(
                  title: Text(AppString.appLock),
                ),
                const Divider(),
                const ListTile(
                  title: Text(AppString.changeUsername),
                ),
                const Divider(),
                ListTile(
                  title: const Text(AppString.changePassword),
                  onTap: () {

                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text(AppString.sendFeedback),
                  onTap: () {

                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    AppString.deActiveAccount,
                    style: TextStyle(
                      color: AppColor.red,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  onTap: () {

                  },
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
