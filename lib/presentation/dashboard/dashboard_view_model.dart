import 'package:flutter/material.dart';
import 'package:librarium/core/route_manager.dart';
import 'package:librarium/injection.dart';
import 'package:librarium/model/common_model/other_user.dart';
import 'package:librarium/model/dashboard_item.dart';
import 'package:librarium/presentation/common/main_view_model.dart';
import 'package:librarium/service/dashboard_service/dashboard_service.dart';
import 'package:librarium/service/quote_service/quote_service.dart';
import 'package:logger/logger.dart';

class DashboardViewModel extends MainViewModel {
  DashboardViewModel(super.context);

  @override
  void start() {
    // TODO: implement start
    findDashboardItemsByUserAndFollowers();
  }

  Logger logger = Logger();

  listenToChanges() {
    notifyListeners();
  }

  final DashboardService _dashboardService = locator<DashboardService>();
  final QuoteService _quoteService = locator<QuoteService>();

  goAddPostView() {
    Navigator.pushNamed(context, AppRoute.addPostRoute);
  }

  goAddQuoteView() {
    Navigator.pushNamed(context, AppRoute.addQuoteRoute);
  }


  int pageNumber = 0;
  bool hasMore = true;

  List<DashboardItem> dashboardItems = [];
  List<DashboardItem> dashboardItemsPart = [];
  findDashboardItemsByUserAndFollowers() async {
    dashboardItemsPart = await _dashboardService.findDashboardItemsByUserAndFollowers(pageNumber);
    dashboardItems.addAll(dashboardItemsPart);
    if (dashboardItemsPart.isEmpty) {
      hasMore = false;
    }
    pageNumber++;
    notifyListeners();
  }

  OtherUser otherUser = OtherUser();

  goOtherProfile({String otherUserId = ""}) async {
    navigateOtherUserProfileWithParam(context, otherUserId);
  }

  bool likeBoolean = false;
  likeQuote({String quoteId = ""}) async {
    likeBoolean = await _quoteService.likeQuote(quoteId);
    notifyListeners();
  }

  bool dislikeBoolean = false;
  dislikeQuote({String quoteId = ""}) async {
    dislikeBoolean = await _quoteService.likeQuote(quoteId);
    notifyListeners();
  }

}
