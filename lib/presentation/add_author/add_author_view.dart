import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:librarium/presentation/add_author/add_author_view_model.dart';
import 'package:librarium/presentation/resources/color_manager.dart';
import 'package:stacked/stacked.dart';

import '../resources/string_manager.dart';

class AddAuthorView extends StatefulWidget {
  const AddAuthorView({Key? key}) : super(key: key);

  @override
  State<AddAuthorView> createState() => _AddAuthorViewModelState();
}

class _AddAuthorViewModelState extends State<AddAuthorView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ViewModelBuilder<AddAuthorViewModel>.reactive(
      viewModelBuilder: () => AddAuthorViewModel(context),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: AppBar(
          title: const Text("Add Author"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: viewModel.firstNameController,
                onChanged: (val) => viewModel.listenToChanges(),
                decoration: const InputDecoration(
                  label: Text(AppString.firstName),
                  prefixIcon: Icon(Icons.keyboard_arrow_right_sharp)
                ),
              ),
              TextFormField(
                controller: viewModel.lastNameController,
                onChanged: (val) => viewModel.listenToChanges(),
                decoration: const InputDecoration(
                  label: Text(AppString.lastName),
                  prefixIcon: Icon(Icons.keyboard_arrow_right_sharp)
                ),
              ),
              TextFormField(
                controller: viewModel.ageController,
                onChanged: (val) => viewModel.listenToChanges(),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                  label: Text(AppString.age),
                  prefixIcon: Icon(Icons.keyboard_arrow_right_sharp)
                ),
              ),
              TextFormField(
                controller: viewModel.nationalityController,
                onChanged: (val) => viewModel.listenToChanges(),
                decoration: const InputDecoration(
                  label: Text(AppString.nationality),
                  prefixIcon: Icon(Icons.keyboard_arrow_right_sharp)
                ),
              ),
              TextFormField(
                controller: viewModel.birthDateController,
                decoration: const InputDecoration(
                  label: Text(AppString.birthDate),
                  prefixIcon: Icon(Icons.date_range)
                ),
                onTap: () => viewModel.pickBirthDate()
              ),
              TextFormField(
                controller: viewModel.deathDateController,
                decoration: const InputDecoration(
                  label: Text(AppString.deathDate),
                  prefixIcon: Icon(Icons.date_range)
                ),
                onTap: () => viewModel.pickDeathDate()
              ),
              const Expanded(
                child: SizedBox(),
              ),
              ElevatedButton(
                onPressed: viewModel.checkAll()
                  ? () => viewModel.addAuthor()
                  : null,
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(size.width/2, size.height/16),
                ),
                child: const Text(AppString.register),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
