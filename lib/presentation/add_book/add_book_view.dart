import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:librarium/presentation/add_book/add_book_view_model.dart';
import 'package:stacked/stacked.dart';

import '../resources/string_manager.dart';

class AddBookView extends StatefulWidget {
  const AddBookView({Key? key}) : super(key: key);

  @override
  State<AddBookView> createState() => _AddBookViewState();
}

class _AddBookViewState extends State<AddBookView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ViewModelBuilder<AddBookViewModel>.reactive(
      viewModelBuilder: () {
        AddBookViewModel viewModel = AddBookViewModel(context);
        viewModel.start();
        return viewModel;
      },
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Add Book"),
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
                    GestureDetector(
                      onTap: () => viewModel.useGallery(),
                      child: Card(
                        child: Center(
                          child: viewModel.coverImage != null
                            ? Image.memory(viewModel.coverImageBytes!)
                            : const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(AppString.addCoverImage),
                          ),
                        ),
                      ),
                    ),
                    viewModel.coverImage != null
                      ? Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 16.0),
                      child: Column(
                        children: [
                          OutlinedButton(
                            onPressed: () => viewModel.zoomImage(),
                            child: const Icon(Icons.search),
                          ),
                          OutlinedButton(
                            onPressed: () => viewModel.removeImage(),
                            child: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    )
                    : const SizedBox(),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                              onPressed: () => viewModel.showSelectAuthorDialog(),
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(size.width/2, size.height/16),
                              ),
                              child: Text(viewModel.selectedAuthor != null ? "${viewModel.selectedAuthor?.firstName} ${viewModel.selectedAuthor?.lastName}" : AppString.selectAuthor),
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
                              onChanged: (val) => viewModel.imChanging(),
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
                                onChanged: (val) => viewModel.imChanging(),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZıIğĞüÜşŞöÖçÇ ]'))
                                ],
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
                                onChanged: (val) => viewModel.imChanging(),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
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
                                onChanged: (val) => viewModel.imChanging(),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
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
                                onChanged: (val) => viewModel.imChanging(),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
                                ],
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
                              onChanged: (val) => viewModel.imChanging(),
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
              ElevatedButton(
                onPressed: viewModel.checkAll()
                  ? () => viewModel.saveBook()
                  : null,
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(size.width/2, size.height/16),
                ),
                child: const Text(AppString.saveBook),
              )
            ],
          ),
        ),
      ),
    );
  }
}
