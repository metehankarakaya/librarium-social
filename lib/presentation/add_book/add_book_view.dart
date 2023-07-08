import 'package:flutter/material.dart';
import 'package:librarium/presentation/add_book/add_book_view_model.dart';
import 'package:stacked/stacked.dart';

class AddBookView extends StatefulWidget {
  const AddBookView({Key? key}) : super(key: key);

  @override
  State<AddBookView> createState() => _AddBookViewState();
}

class _AddBookViewState extends State<AddBookView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddBookViewModel>.reactive(
      viewModelBuilder: () => AddBookViewModel(context),
      builder: (context, viewModel, child) => Scaffold(

      ),
    );
  }
}
