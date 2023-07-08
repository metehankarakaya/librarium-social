import 'package:flutter/material.dart';
import 'package:librarium/presentation/login/login_view_model.dart';
import 'package:librarium/presentation/resources/string_manager.dart';
import 'package:stacked/stacked.dart';

import '../resources/asset_manager.dart';
import '../resources/color_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(context),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: AppBar(
          title: const Text(AppString.appName),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.40,
                child: Image.asset(AppAsset.loginLogo)
              ),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () => viewModel.goRegister(),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: const Text(AppString.haveNotAccount),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: viewModel.checkAll()
                  ? () => viewModel.logIn()
                  : null,
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(size.width/2, size.height/16),
                ),
                child: const Text(AppString.login),
              ),
              SizedBox(height: size.height/8,),
            ],
          ),
        ),
      ),
    );
  }
}
