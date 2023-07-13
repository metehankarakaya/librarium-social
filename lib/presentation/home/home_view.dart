import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:librarium/presentation/common/quote_card_view.dart';
import 'package:librarium/presentation/drawer/drawer_view.dart';
import 'package:librarium/presentation/home/home_view_model.dart';
import 'package:librarium/presentation/resources/color_manager.dart';
import 'package:librarium/presentation/resources/string_manager.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () {
        HomeViewModel viewModel = HomeViewModel(context);
        viewModel.start();
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
              icon: const Icon(Icons.message_sharp),
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
              physics: const BouncingScrollPhysics(),
              itemCount: viewModel.quotes.length,
              itemBuilder: (context, index) {
                return QuoteCard(
                  viewModel: viewModel,
                  quote: viewModel.quotes[index],
                  onLike: () => viewModel.likeQuote(),
                  onDislike: () => viewModel.dislikeQuote(),
                  goOtherProfile: () => viewModel.goOtherProfile(),
                );
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
