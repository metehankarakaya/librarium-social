import 'package:flutter/material.dart';
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
        backgroundColor: AppColor.bgColor,
        drawer: const DrawerView(),
        appBar: AppBar(
          title: const Text(AppString.dashboard),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: viewModel.refreshDash,
          child: ListView.builder(
            itemCount: viewModel.quotes.length,
            itemBuilder: (context, index) {
              return QuoteCard(
                viewModel: viewModel,
                quote: viewModel.quotes[index],
                onLike: () => viewModel.likeQuote(),
                onDislike: () => viewModel.dislikeQuote(),
              );
            },
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
