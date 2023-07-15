import 'package:flutter/material.dart';
import 'package:librarium/presentation/resources/string_manager.dart';

import '../../../profile/profile_view_model.dart';

void addedBooksDialog(BuildContext context, ProfileViewModel viewModel) {
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
                          viewModel.filterFoundBooks(value);
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: AppString.searchBook,
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
                          itemCount: viewModel.filteredFoundBooks.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const Icon(Icons.keyboard_arrow_right_sharp),
                              title: Text("${viewModel.filteredFoundBooks[index].title}"),
                              subtitle: Text("${viewModel.filteredFoundBooks[index].author?.firstName} ${viewModel.filteredFoundBooks[index].author?.lastName}"),
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
