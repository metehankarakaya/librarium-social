import 'package:flutter/material.dart';
import 'package:librarium/model/book.dart';
import 'package:librarium/model/quote.dart';
import 'package:librarium/presentation/common/dialog/rules_dialog/show_add_quote_rules_dialog.dart';
import 'package:librarium/presentation/common/main_view_model.dart';
import 'package:librarium/service/quote_service/quote_service.dart';
import 'package:logger/logger.dart';

import '../../injection.dart';
import '../../service/book_service/book_service.dart';
import '../common/dialog/select_book_dialog.dart';
import '../common/snack_bar/show_snack_bar.dart';
import '../resources/string_manager.dart';

class AddQuoteViewModel extends MainViewModel {
  AddQuoteViewModel(super.context);

  @override
  void start() {
    // TODO: implement start
    findAllBooks();
  }

  Logger logger = Logger();

  listenToChanges() {
    notifyListeners();
  }

  checkAll() {
    if (selectedBook == null) {
      return false;
    }
    if (contentController.text.isEmpty) {
      return false;
    }
    if (pageNumberController.text.isEmpty || pageNumberController.text.length > 6) {
      return false;
    }
    return true;
  }

  final BookService _bookService = locator<BookService>();
  final QuoteService _quoteService = locator<QuoteService>();

  TextEditingController contentController = TextEditingController();
  TextEditingController pageNumberController = TextEditingController();

  showAddQuoteRules() {
    showAddQuoteRulesDialog(context);
  }

  List<Book> foundBooks = [];
  List<Book> filteredFoundBooks = [];

  findAllBooks() async {
    foundBooks = await _bookService.findAllBooks();
    filteredFoundBooks = foundBooks;
    notifyListeners();
  }

  void filterBookList(String val) {
    if (val.isEmpty) {
      filteredFoundBooks = foundBooks;
      notifyListeners();
    }
    else {
      filteredFoundBooks = foundBooks
        .where(
          (element) =>
        element.title!.toLowerCase().contains(val.toLowerCase())).toList();
      notifyListeners();
    }
  }

  Book? selectedBook;

  showSelectBookDialog() {
    selectBookDialog(context, this);
  }

  selectBook(Book? val) {
    selectedBook = val!;
    notifyListeners();
    Navigator.pop(context);
  }

  final Quote _quote = Quote();
  bool addedQuote = false;

  addQuote() async {
    _quote.content = contentController.text.trim();
    _quote.book = selectedBook;
    _quote.pageNumber = int.parse(pageNumberController.text.trim());
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
    contentController.clear();
    pageNumberController.clear();
    notifyListeners();
  }


}