import 'package:flutter/material.dart';
import 'package:librarium/presentation/register/register_view_model.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => RegisterViewModel(context),
      builder: (context, viewModel, child) => Scaffold(

      ),
    );
  }
}
