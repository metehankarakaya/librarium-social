import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:librarium/presentation/common/quote_card_view.dart';
import 'package:librarium/presentation/drawer/drawer_view.dart';
import 'package:librarium/presentation/home/home_view_model.dart';
import 'package:librarium/presentation/resources/color_manager.dart';
import 'package:librarium/presentation/resources/string_manager.dart';
import 'package:librarium/presentation/resources/svg_manager.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  late HomeViewModel viewModel;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = HomeViewModel(context);
    viewModel.start();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        viewModel.findQuotesByUserAndFollowings();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () {
        return viewModel;
      },
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: const Color(0xFFfff9eb),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () => viewModel.goAddQuoteView(),
          backgroundColor: AppColor.blue900,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
