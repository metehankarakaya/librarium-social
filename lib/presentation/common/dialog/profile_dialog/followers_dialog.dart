import 'package:flutter/material.dart';

import '../../../profile/profile_view_model.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/string_manager.dart';

void followersDialog(BuildContext context, ProfileViewModel viewModel) {
  Size size = MediaQuery.sizeOf(context);
  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return SimpleDialog(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          viewModel.filterFoundFollowers(value);
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: AppString.searchUser,
                        suffixIcon: Icon(Icons.search)
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overScroll) {
                          overScroll.disallowIndicator();
                          return true;
                        },
                        child: ListView.builder(
                          itemCount: viewModel.filteredFoundFollowers.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Icon(Icons.person, color: AppColor.blue900,),
                              title: Text("${viewModel.filteredFoundFollowers[index].username}"),
                              subtitle: Text("${viewModel.filteredFoundFollowers[index].firstName} ${viewModel.filteredFoundFollowers[index].lastName}"),
                              dense: true,
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    )
  );
}
