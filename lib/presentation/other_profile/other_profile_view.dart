import 'package:flutter/material.dart';
import 'package:librarium/presentation/other_profile/other_profile_view_model.dart';
import 'package:stacked/stacked.dart';

import '../common/button/profile_button_view.dart';
import '../resources/color_manager.dart';
import '../resources/string_manager.dart';

class OtherProfileView extends StatefulWidget {
  final String otherUserId;

  const OtherProfileView({
    Key? key,
    required this.otherUserId
  }) : super(key: key);

  @override
  State<OtherProfileView> createState() => _OtherProfileViewState();
}

class _OtherProfileViewState extends State<OtherProfileView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ViewModelBuilder<OtherProfileViewModel>.reactive(
      viewModelBuilder: () {
        OtherProfileViewModel viewModel = OtherProfileViewModel(context);
        viewModel.findOtherUserDetail(widget.otherUserId);
        return viewModel;
      },
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColor.bgColor,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: AppColor.blue900,),
          ),
          backgroundColor: AppColor.transparent,
          elevation: 0,
          actions: [
            viewModel.otherUser.id != viewModel.otherUser.visitorId
              ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: () => viewModel.isFollow! ? viewModel.unFollowOtherUser("${viewModel.otherUser.id}") : viewModel.followOtherUser("${viewModel.otherUser.id}"),
                  child: Text(viewModel.isFollow == true ? AppString.followings : AppString.follow),
                ),
              )
              : const SizedBox(),
            viewModel.otherUser.id != viewModel.otherUser.visitorId
              ? IconButton(
                onPressed: () {

                },
                splashRadius: 20,
                icon: Icon(Icons.more_vert, color: AppColor.blue900,),
              )
              : const SizedBox()
          ],
        ),
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.zero,
                child: GestureDetector(
                  onTap: () => viewModel.showFullAvatar(),
                  child: CircleAvatar(
                    radius: 150,
                    backgroundColor: AppColor.transparent,
                    backgroundImage: viewModel.otherUser.avatar != null
                      ? MemoryImage(viewModel.otherUser.avatar!)
                      : null,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "@${viewModel.otherUser.username}",
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                  "${viewModel.otherUser.firstName} ${viewModel.otherUser.lastName}",
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
                      onPressed: () => viewModel.showQuotesDialog(),
                      content: AppString.quotes,
                      count: "${viewModel.otherUser.quotes?.length}",
                    ),
                    ProfileButtonView(
                      onPressed: () => viewModel.showAddedBooksDialog(),
                      content: AppString.books,
                      count: "${viewModel.otherUser.addedBooks?.length}",
                    ),
                    ProfileButtonView(
                      onPressed: () => viewModel.showFollowingsDialog(),
                      content: AppString.followings,
                      count: "${viewModel.otherUser.followings?.length}",
                    ),
                    ProfileButtonView(
                      onPressed: () => viewModel.showFollowersDialog(),
                      content: AppString.followers,
                      count: "${viewModel.otherUser.followers?.length}",
                    ),
                  ],
                ),
              ),
              const Divider(),
              ListTile(
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
                child: ListTile(
                  title: Text(
                    viewModel.otherUser.aboutMe ?? "",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
