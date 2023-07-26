import 'package:flutter/material.dart';
import 'package:librarium/presentation/profile/profile_view_model.dart';
import 'package:stacked/stacked.dart';

import '../common/button/profile_button_view.dart';
import '../resources/color_manager.dart';
import '../resources/string_manager.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () {
        ProfileViewModel viewModel = ProfileViewModel(context);
        viewModel.start();
        return viewModel;
      },
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColor.bgColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: AppColor.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () => viewModel.goSettingView(),
              splashRadius: 20,
              icon: const Icon(Icons.settings, color: AppColor.grey,),
            )
          ],
        ),
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CircleAvatar(
                  radius: 150,
                  backgroundColor: AppColor.transparent,
                  backgroundImage: viewModel.user.avatar != null
                    ? MemoryImage(viewModel.user.avatar!)
                    : null,
                ),
              ),
              ListTile(
                title: Text(
                  "@${viewModel.user.username}",
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                  "${viewModel.user.firstName} ${viewModel.user.lastName}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ProfileButtonView(
                      onPressed: viewModel.isBusy
                        ? null
                        : () => viewModel.showQuotesDialog(),
                      content: AppString.quotes,
                      count: "${viewModel.user.quotes?.length}",
                    ),
                    ProfileButtonView(
                      onPressed: viewModel.isBusy
                        ? null
                        : () => viewModel.showAddedBooksDialog(),
                      content: AppString.books,
                      count: "${viewModel.user.addedBooks?.length}",
                    ),
                    ProfileButtonView(
                      onPressed: viewModel.isBusy
                        ? null
                        : () => viewModel.showFollowingsDialog(),
                      content: AppString.followings,
                      count: "${viewModel.user.followings?.length}",
                    ),
                    ProfileButtonView(
                      onPressed: viewModel.isBusy
                        ? null
                        : () => viewModel.showFollowersDialog(),
                      content: AppString.followers,
                      count: "${viewModel.user.followers?.length}",
                    ),
                  ],
                ),
              ),
              const Divider(),
              ListTile(
                trailing: IconButton(
                  //onPressed: () => viewModel.showEditAboutMeDialog(),
                  onPressed: () => viewModel.changeReadOnly(),
                  splashRadius: 20,
                  icon: Icon(
                    Icons.edit,
                    color: AppColor.blue900,
                  ),
                ),
                title: Text(
                  AppString.aboutMe.toUpperCase(),
                  style: TextStyle(
                    color: AppColor.blue900,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.italic,
                    fontSize: 32,
                    decoration: TextDecoration.underline
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: viewModel.aboutMeController,
                  maxLength: 500,
                  maxLines: 7,
                  readOnly: viewModel.readOnlyBool,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.blue900
                      ),
                    ),
                  ),
                )
              ),
              ElevatedButton(
                onPressed: viewModel.readOnlyBool
                  ? null
                  : () => viewModel.editAboutMe(),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(size.width/2, size.height/16),
                ),
                child: const Text("Edit About Me"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
