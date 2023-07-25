import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:librarium/presentation/dashboard/dashboard_view_model.dart';
import 'package:librarium/presentation/drawer/drawer_view.dart';
import 'package:librarium/presentation/resources/color_manager.dart';
import 'package:librarium/presentation/resources/string_manager.dart';
import 'package:librarium/presentation/resources/svg_manager.dart';
import 'package:stacked/stacked.dart';

import '../common/quote_card_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  late DashboardViewModel viewModel;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = DashboardViewModel(context);
    viewModel.start();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        viewModel.findQuotesByUserAndFollowings();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () {
        return viewModel;
      },
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColor.bgColor,
        drawer: const DrawerView(),
        appBar: AppBar(
          title: const Text(AppString.dashboard),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {

              },
              splashRadius: 20,
              icon: SvgPicture.asset(
                AppSvg.messageIcon
              ),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: viewModel.refreshDash,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowIndicator();
              return true;
            },
            child: ListView.builder(
              controller: scrollController,
              itemCount: viewModel.quotes.length + 1,
              itemBuilder: (context, index) {
                if (index < viewModel.quotes.length) {
                  return QuoteCard(
                    viewModel: viewModel,
                    quote: viewModel.quotes[index],
                    onLike: () => viewModel.likeQuote(),
                    onDislike: () => viewModel.dislikeQuote(),
                    goOtherProfile: () => viewModel.goOtherProfile(),
                  );
                }
                else {
                  if (!viewModel.hasMore) {
                    return const ListTile(
                      title: Text(AppString.noMoreQuote, textAlign: TextAlign.center,),
                    );
                  }
                  else {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                }
              },
            ),
          ),
        ),
        floatingActionButton: SpeedDial(
          backgroundColor: AppColor.blue900,
          overlayColor: AppColor.black,
          activeBackgroundColor: AppColor.blue900,
          spacing: 5,
          animationAngle: -5000,
          children: [
            SpeedDialChild(
              child: const Text(AppString.quote),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20))
              ),
              onTap: () => viewModel.goAddQuoteView()
            ),
            SpeedDialChild(
              child: const Text(AppString.post),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20))
              ),
              onTap: () => viewModel.goAddPostView()
            )
          ],
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
