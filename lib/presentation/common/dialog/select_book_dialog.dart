import 'package:flutter/material.dart';
import 'package:librarium/presentation/add_quote/add_quote_view_model.dart';

import '../../resources/string_manager.dart';

void selectBookDialog(BuildContext context, AddQuoteViewModel viewModel) {
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
                          viewModel.filterBookList(val);
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: AppString.searchBook,
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
                        itemCount: viewModel.filteredFoundBooks.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text("${viewModel.filteredFoundBooks[index].title}"),
                                subtitle: Text("${viewModel.filteredFoundBooks[index].author?.firstName} ${viewModel.filteredFoundBooks[index].author?.lastName}"),
                                onTap: () => viewModel.selectBook(viewModel.filteredFoundBooks[index]),
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
