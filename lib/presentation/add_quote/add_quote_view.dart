import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:librarium/presentation/add_quote/add_quote_view_model.dart';
import 'package:librarium/presentation/resources/color_manager.dart';
import 'package:librarium/presentation/resources/string_manager.dart';
import 'package:stacked/stacked.dart';

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
      viewModelBuilder: () {
        AddQuoteViewModel viewModel = AddQuoteViewModel(context);
        viewModel.start();
        return viewModel;
      },
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: AppBar(
          backgroundColor: AppColor.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => viewModel.goBack(),
            splashRadius: 20,
            icon: Icon(Icons.close, color: AppColor.blue900,),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: size.width/4,
                child: ElevatedButton(
                  onPressed: viewModel.checkAll()
                    ? () => viewModel.addQuoteToDraft()
                    : null,
                  child: const Text(AppString.draft),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: size.width/4,
                child: ElevatedButton(
                  onPressed: viewModel.checkAll()
                    ? () => viewModel.addQuote()
                    : null,
                  child: const Text(AppString.quote),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowIndicator();
              return true;
            },
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: viewModel.user.avatar != null
                            ? MemoryImage(viewModel.user.avatar!)
                            : null,
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            "@${viewModel.user.username}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("${viewModel.user.firstName} ${viewModel.user.lastName}"),
                        ),
                      )
                    ],
                  ),
                ),
                TextFormField(
                  autofocus: true,
                  controller: viewModel.contentController,
                  onChanged: (val) => viewModel.listenToChanges(),
                  maxLines: null,
                  maxLength: 2000,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    label: const Text(AppString.quote),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColor.blue900
                      ),
                    )
                  ),
                ),
                TextFormField(
                  controller: viewModel.pageNumberController,
                  onChanged: (val) => viewModel.listenToChanges(),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], //
                  decoration: const InputDecoration(
                    label: Text(AppString.pageNumber),
                    prefixIcon: Icon(Icons.keyboard_arrow_right_sharp)
                  ),
                ),
                SizedBox(height: size.height/32,),
                OutlinedButton(
                  onPressed: () => viewModel.showSelectBookDialog(),
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      color: AppColor.indigo400
                    ),
                    fixedSize: Size(size.width, size.height/12),
                  ),
                  child: Text(viewModel.selectedBook != null ? "${viewModel.selectedBook?.title}": AppString.selectBook),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
