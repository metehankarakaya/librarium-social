import 'package:flutter/material.dart';
import 'package:librarium/presentation/explore/user_search/user_search_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../resources/color_manager.dart';
import '../../resources/string_manager.dart';

class UserSearchView extends StatefulWidget {
  const UserSearchView({Key? key}) : super(key: key);

  @override
  State<UserSearchView> createState() => _UserSearchViewState();
}

class _UserSearchViewState extends State<UserSearchView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ViewModelBuilder<UserSearchViewModel>.reactive(
      viewModelBuilder: () {
        UserSearchViewModel viewModel = UserSearchViewModel(context);
        viewModel.start();
        return viewModel;
      },
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColor.bgColor,
        body: Column(
          children: [
            TextFormField(
              onChanged: (val) {},
              decoration: const InputDecoration(
                hintText: AppString.searchUser,
                prefixIcon: Icon(Icons.search),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 8.0, bottom: 4.0),
                child: Text(
                  AppString.randomUsers,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 24,
                    decoration: TextDecoration.underline,
                  ),
                )
              ),
            ),
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowIndicator();
                return true;
              },
              child: SizedBox(
                width: size.width,
                height: size.height/5,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: viewModel.randomUsers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 8.0),
                      child: GestureDetector(
                        onTap: () => viewModel.goOtherProfile(otherUserId: viewModel.randomUsers[index].id!),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.memory(viewModel.randomUsers[index].avatar!, fit: BoxFit.cover,),
                        )
                      ),
                    );
                  },
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
