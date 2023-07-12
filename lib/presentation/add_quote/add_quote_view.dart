import 'package:flutter/material.dart';
import 'package:librarium/presentation/add_quote/add_quote_view_model.dart';
import 'package:librarium/presentation/resources/color_manager.dart';
import 'package:stacked/stacked.dart';

import '../resources/string_manager.dart';

class AddQuoteView extends StatefulWidget {
  const AddQuoteView({Key? key}) : super(key: key);

  @override
  State<AddQuoteView> createState() => _AddQuoteViewState();
}

class _AddQuoteViewState extends State<AddQuoteView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ViewModelBuilder<AddQuoteViewModel>.reactive(
      viewModelBuilder: () => AddQuoteViewModel(context),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: AppBar(
          title: const Text(AppString.addQuote),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => viewModel.showAddQuoteRules(),
              splashRadius: 20,
              icon: const Icon(Icons.info_outline,),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: viewModel.contentController,
                onChanged: (val) => viewModel.listenToChanges(),
                maxLines: 15,
                minLines: 1,
                maxLength: 2000,
                decoration: const InputDecoration(
                  label: Text(AppString.content),
                  prefixIcon: Icon(Icons.keyboard_arrow_right_sharp)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: viewModel.checkAll()
                    ? () => viewModel.addQuote()
                    : null,
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(size.width/2, size.height/16),
                  ),
                  child: const Text(AppString.send),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
