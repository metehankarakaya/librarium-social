import 'package:flutter/material.dart';
import 'package:librarium/presentation/resources/color_manager.dart';

import '../../../resources/string_manager.dart';

void followingsDialog(BuildContext context, {dynamic viewModel}) {
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
                          viewModel.filterFoundFollowings(value);
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
                          itemCount: viewModel.filteredFoundFollowings.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Icon(Icons.person, color: AppColor.blue900,),
                              title: Text("${viewModel.filteredFoundFollowings[index].username}"),
                              subtitle: Text("${viewModel.filteredFoundFollowings[index].firstName} ${viewModel.filteredFoundFollowings[index].lastName}"),
                              onTap: () => viewModel.goOtherProfile(otherUserId: viewModel.filteredFoundFollowings[index].id ?? ""),
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
