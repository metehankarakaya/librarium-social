import 'package:flutter/material.dart';
import 'package:librarium/presentation/resources/color_manager.dart';
import 'package:librarium/presentation/resources/string_manager.dart';


void showAddBookRulesDialog(BuildContext context) {
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
              title: Text(AppString.titleRule),
            ),
            ListTile(
              title: Text(AppString.languageRule),
            ),
            ListTile(
              title: Text(AppString.isbnRule),
            ),
            ListTile(
              title: Text(AppString.pageCountRule),
            ),
            ListTile(
              title: Text(AppString.priceRule),
            ),
            ListTile(
              title: Text(AppString.descriptionRule),
            ),
            ListTile(
              title: Text(AppString.authorSelectRule),
            ),
          ],
        );
      },
    )
  );
}
