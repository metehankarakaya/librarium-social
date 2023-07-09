import 'package:flutter/material.dart';

import '../../add_book/add_book_view_model.dart';
import '../../resources/string_manager.dart';

void selectAuthorDialog(BuildContext context, AddBookViewModel viewModel) {
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
                      onChanged: (val) {
                        setState(() {
                          viewModel.filterAuthorList(val);
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: AppString.searchAuthor,
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ListView.builder(
                        itemCount: viewModel.filteredAuthorList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text("${viewModel.filteredAuthorList[index].firstName} ${viewModel.filteredAuthorList[index].lastName}"),
                                onTap: () => viewModel.selectAuthor(viewModel.filteredAuthorList[index]),
                                dense: true,
                              ),
                              const Divider(),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }
    )
  );
}
