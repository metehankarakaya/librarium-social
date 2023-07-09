import 'package:flutter/material.dart';

import '../../../profile/profile_view_model.dart';

void quotesDialog(BuildContext context, ProfileViewModel viewModel) {
  Size size = MediaQuery.sizeOf(context);
  showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return SimpleDialog(
            children: [

            ],
          );
        },
      )
  );
}
