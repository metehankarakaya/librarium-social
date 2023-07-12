import 'package:flutter/material.dart';
import 'package:librarium/core/route_manager.dart';
import 'package:librarium/injection.dart';
import 'package:librarium/model/common_model/other_user.dart';
import 'package:librarium/model/quote.dart';
import 'package:librarium/presentation/common/main_view_model.dart';
import 'package:librarium/service/quote_service/quote_service.dart';
import 'package:librarium/service/user_service/user_service.dart';
import 'package:logger/logger.dart';

class HomeViewModel extends MainViewModel {
  HomeViewModel(super.context);

  @override
  void start() {
    // TODO: implement start
    getAllQuotes();
  }

  Logger logger = Logger();

  listenToChanges() {
    notifyListeners();
  }

  final UserService _userService = locator<UserService>();
  final QuoteService _quoteService = locator<QuoteService>();

  goAddQuoteView() {
    Navigator.pushNamed(context, AppRoute.addQuoteRoute);
  }

  Future<void> refreshDash() async {
    getAllQuotes();
  }

  List<Quote> quotes = [];

  getAllQuotes() async {
    quotes = await _quoteService.findAllQuotes();
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
