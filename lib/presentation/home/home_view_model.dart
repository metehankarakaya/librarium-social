import 'package:flutter/material.dart';
import 'package:librarium/core/route_manager.dart';
import 'package:librarium/injection.dart';
import 'package:librarium/model/quote.dart';
import 'package:librarium/presentation/common/main_view_model.dart';
import 'package:librarium/service/quote_service/quote_service.dart';
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

}
