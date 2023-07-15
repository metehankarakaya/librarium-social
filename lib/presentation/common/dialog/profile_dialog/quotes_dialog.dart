import 'package:flutter/material.dart';

import '../../../profile/profile_view_model.dart';
import '../../../resources/string_manager.dart';

void quotesDialog(BuildContext context, ProfileViewModel viewModel) {
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
                          viewModel.filterFoundQuotes(value);
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: AppString.searchQuote,
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
                          itemCount: viewModel.filteredFoundQuotes.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const Icon(Icons.keyboard_arrow_right_sharp),
                              title: Text(
                                "${viewModel.filteredFoundQuotes[index].content}",
                                maxLines: 5,
                                style: const TextStyle(overflow: TextOverflow.ellipsis),
                              ),
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
