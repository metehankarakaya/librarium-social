import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:librarium/presentation/explore/book_search/book_search_view.dart';
import 'package:librarium/presentation/explore/explore_view_model.dart';
import 'package:librarium/presentation/explore/user_search/user_search_view.dart';
import 'package:librarium/presentation/resources/color_manager.dart';
import 'package:stacked/stacked.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExploreViewModel>.reactive(
      viewModelBuilder: () => ExploreViewModel(context),
      builder: (context, viewModel, child) => DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              Container(
                color: AppColor.blue900,
                child: SafeArea(
                  child: TabBar(
                    indicatorColor: AppColor.transparent,
                    labelColor: AppColor.white,
                    unselectedLabelColor: AppColor.indigo400,
                    tabs: const [
                      Tab(icon: Icon(Icons.person),),
                      Tab(icon: Icon(FontAwesomeIcons.bookOpen),),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overScroll) {
                    overScroll.disallowIndicator();
                    return true;
                  },
                  child: const TabBarView(
                    children: [
                      UserSearchView(),
                      BookSearchView()
                    ],
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
