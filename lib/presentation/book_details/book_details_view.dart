import 'package:flutter/material.dart';
import 'package:librarium/presentation/book_details/book_details_view_model.dart';
import 'package:stacked/stacked.dart';

import '../resources/string_manager.dart';

class BookDetailsView extends StatefulWidget {
  final String bookId;

  const BookDetailsView({
    Key? key,
    required this.bookId
  }) : super(key: key);

  @override
  State<BookDetailsView> createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends State<BookDetailsView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ViewModelBuilder<BookDetailsViewModel>.reactive(
      viewModelBuilder: () {
        BookDetailsViewModel viewModel = BookDetailsViewModel(context);
        viewModel.findBookDetails(widget.bookId);
        return viewModel;
      },
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(viewModel.foundBook.title ?? ""),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                height: size.height/5,
                child: Row(
                  children: [
                    Card(
                      child: Center(
                        child: viewModel.foundBook.coverImage != null
                          ? Image.memory(viewModel.foundBook.coverImage!)
                          : const SizedBox()
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 16.0),
                      child: Column(
                        children: [
                          OutlinedButton(
                            onPressed: () => viewModel.zoomImage(),
                            child: const Icon(Icons.search),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(size.width/2, size.height/16),
                              ),
                              child: Text("${viewModel.foundBook.author?.firstName} ${viewModel.foundBook.author?.lastName}"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  primary: false,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: viewModel.titleController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                label: Text(AppString.title),
                                prefixIcon: Icon(Icons.keyboard_arrow_right_sharp)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: viewModel.languageController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  label: Text(AppString.language),
                                  prefixIcon: Icon(Icons.keyboard_arrow_right_sharp)
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: viewModel.isbnController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  label: Text(AppString.isbn),
                                  prefixIcon: Icon(Icons.keyboard_arrow_right_sharp)
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: viewModel.pageCountController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  label: Text(AppString.pageCount),
                                  prefixIcon: Icon(Icons.keyboard_arrow_right_sharp)
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: viewModel.priceController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  label: Text(AppString.price),
                                  prefixIcon: Icon(Icons.keyboard_arrow_right_sharp)
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: viewModel.descriptionController,
                              readOnly: true,
                              maxLength: 500,
                              maxLines: 10,
                              minLines: 1,
                              decoration: const InputDecoration(
                                label: Text(AppString.description),
                                prefixIcon: Icon(Icons.keyboard_arrow_right_sharp)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
