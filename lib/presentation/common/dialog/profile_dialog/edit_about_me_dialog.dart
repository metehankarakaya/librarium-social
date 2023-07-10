import 'package:flutter/material.dart';
import 'package:librarium/presentation/profile/profile_view_model.dart';

import '../../../resources/string_manager.dart';

void editAboutMeDialog(BuildContext context, ProfileViewModel viewModel) {
  Size size = MediaQuery.sizeOf(context);
  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: const Text("Edit your About Me"),
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: viewModel.aboutMeController,
              onChanged: (val) => viewModel.listenToChanges(),
              maxLength: 500,
              maxLines: 20,
              minLines: 5,
            ),
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
              onPressed: () => viewModel.editAboutMe(),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width/6, size.height/24),
              ),
              child: const Text(AppString.ok),
            )
          ],
        );
      },
    )
  );
}
