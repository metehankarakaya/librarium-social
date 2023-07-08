import 'package:flutter/material.dart';
import 'package:librarium/presentation/profile/profile_view_model.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(context),
      builder: (context, viewModel, child) => Scaffold(

      ),
    );
  }
}
