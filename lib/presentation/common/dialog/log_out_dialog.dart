import 'package:flutter/material.dart';

import '../../drawer/drawer_view_model.dart';
import '../../resources/color_manager.dart';
import '../../resources/string_manager.dart';

void logOutDialog(BuildContext context, DrawerViewModel viewModel) {
  Size size = MediaQuery.sizeOf(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: ListTile(
          title: Text(
            AppString.confirmationTitle,
            style: TextStyle(
              color: AppColor.blue900,
              fontSize: 18
            ),
          ),
        ),
        content: const ListTile(
          title: Text(AppString.confirmationAlert,),
        ),
        actions: [
          OutlinedButton(
            onPressed: () => viewModel.goBack(),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(size.width/6, size.height/24),
            ),
            child: const Text(AppString.cancel),
          ),
          ElevatedButton(
            onPressed: () => viewModel.logOut(),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(size.width/6, size.height/24),
            ),
            child: const Text(AppString.ok),
          )
        ],
      );
    },
  );

}
