import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/string_manager.dart';

void showSearchKeywordRulesDialog(BuildContext context) {
  Size size = MediaQuery.sizeOf(context);
  showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return SimpleDialog(
            backgroundColor: AppColor.bgColor,
            title: Text(
              AppString.rules,
              style: TextStyle(
                  color: AppColor.blue900,
                  fontWeight: FontWeight.bold
              ),
            ),
            children: const [
              ListTile(
                title: Text(AppString.searchKeywordRule),
              ),
            ],
          );
        },
      )
  );
}
