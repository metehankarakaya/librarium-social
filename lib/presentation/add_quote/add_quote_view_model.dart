import 'package:flutter/material.dart';
import 'package:librarium/model/quote.dart';
import 'package:librarium/presentation/common/dialog/rules_dialog/show_add_quote_rules_dialog.dart';
import 'package:librarium/presentation/common/main_view_model.dart';
import 'package:librarium/service/quote_service/quote_service.dart';
import 'package:logger/logger.dart';

import '../../injection.dart';
import '../common/snack_bar/show_snack_bar.dart';
import '../resources/string_manager.dart';

class AddQuoteViewModel extends MainViewModel {
  AddQuoteViewModel(super.context);

  @override
  void start() {
    // TODO: implement start
  }

  Logger logger = Logger();

  listenToChanges() {
    notifyListeners();
  }

  checkAll() {
    if (contentController.text.isEmpty) {
      return false;
    }
    return true;
  }

  final QuoteService _quoteService = locator<QuoteService>();

  TextEditingController contentController = TextEditingController();
  TextEditingController pageNumberController = TextEditingController();

  showAddQuoteRules() {
    showAddQuoteRulesDialog(context);
  }

  final Quote _quote = Quote();
  bool addedQuote = false;

  addQuote() async {
    _quote.content = contentController.text.trim();
    notifyListeners();
    addedQuote = await _quoteService.addQuote(_quote);
    if (addedQuote) {
      showSnackBar(context, AppString.contentAddSuccessful);
      clearForm();
    }
    else {
      showSnackBar(context, AppString.contentAddFailed);
    }
  }

  clearForm() {
    contentController.text = "";
    pageNumberController.text = "";
    notifyListeners();
  }


}