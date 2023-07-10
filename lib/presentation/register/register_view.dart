import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:librarium/presentation/register/register_view_model.dart';
import 'package:librarium/presentation/resources/color_manager.dart';
import 'package:librarium/presentation/resources/string_manager.dart';
import 'package:stacked/stacked.dart';

import '../resources/asset_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(context),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: AppBar(
          title: const Text(AppString.register),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => viewModel.showRegisterRules(),
              splashRadius: 20,
              icon: const Icon(Icons.info_outline,),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => viewModel.selectImageMode(),
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: AppColor.transparent,
                  backgroundImage: viewModel.pickedImage != null
                    ? FileImage(File(viewModel.pickedImage!.path))
                    : const AssetImage(AppAsset.defaultPp) as ImageProvider,
                ),
              ),
              Expanded(
                child: ListView(
                  primary: false,
                  padding: const EdgeInsets.all(8.0),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    TextFormField(
                      controller: viewModel.usernameController,
                      onChanged: (val) => viewModel.listenToChanges(),
                      decoration: const InputDecoration(
                        label: Text(AppString.username),
                        prefixIcon: Icon(Icons.keyboard_arrow_right_sharp)
                      ),
                    ),
                    TextFormField(
                      controller: viewModel.passwordController,
                      onChanged: (val) => viewModel.listenToChanges(),
                      obscureText: viewModel.obscureText,
                      decoration: InputDecoration(
                        label: const Text(AppString.password),
                        prefixIcon: const Icon(Icons.keyboard_arrow_right_sharp),
                        suffixIcon: IconButton(
                          onPressed: () => viewModel.changeObscureText(),
                          icon: const Icon(Icons.remove_red_eye),
                          splashRadius: 20,
                        )
                      ),
                    ),
                    TextFormField(
                      controller: viewModel.password2Controller,
                      onChanged: (val) => viewModel.listenToChanges(),
                      obscureText: viewModel.obscureText2,
                      decoration: InputDecoration(
                        label: const Text(AppString.passwordAgain),
                        prefixIcon: const Icon(Icons.keyboard_arrow_right_sharp),
                        suffixIcon: IconButton(
                          onPressed: () => viewModel.changeObscureText2(),
                          icon: const Icon(Icons.remove_red_eye),
                          splashRadius: 20,
                        )
                      ),
                    ),
                    TextFormField(
                      controller: viewModel.firstNameController,
                      onChanged: (val) => viewModel.listenToChanges(),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                      ],
                      decoration: const InputDecoration(
                        label: Text(AppString.firstName),
                        prefixIcon: Icon(Icons.keyboard_arrow_right_sharp),
                      ),
                    ),
                    TextFormField(
                      controller: viewModel.lastNameController,
                      onChanged: (val) => viewModel.listenToChanges(),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                      ],
                      decoration: const InputDecoration(
                        label: Text(AppString.lastName),
                        prefixIcon:  Icon(Icons.keyboard_arrow_right_sharp),
                      ),
                    ),
                    TextFormField(
                      controller: viewModel.genderController,
                      onChanged: (val) => viewModel.listenToChanges(),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                      ],
                      decoration: const InputDecoration(
                        label: Text(AppString.gender),
                        prefixIcon: Icon(Icons.keyboard_arrow_right_sharp),
                      ),
                    ),
                    TextFormField(
                      controller: viewModel.aboutMeController,
                      onChanged: (val) => viewModel.listenToChanges(),
                      maxLength: 500,
                      maxLines: 5,
                      minLines: 1,
                      decoration: const InputDecoration(
                        label: Text(AppString.aboutMe),
                        prefixIcon: Icon(Icons.keyboard_arrow_right_sharp),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () => viewModel.goLogin(),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: const Text(AppString.haveAccount),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: viewModel.checkAll()
                  ? () => viewModel.register()
                  : null,
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(size.width/2, size.height/16),
                ),
                child: const Text(AppString.register),
              ),
            ],
          ),
        )
      ),
    );
  }
}
