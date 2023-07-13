import 'package:flutter/material.dart';
import 'package:librarium/model/book.dart';
import 'package:librarium/presentation/common/main_view_model.dart';
import 'package:librarium/service/book_service/book_service.dart';
import 'package:logger/logger.dart';

import '../../../injection.dart';

class BookSearchViewModel extends MainViewModel {
  BookSearchViewModel(super.context);

  @override
  void start() {
    // TODO: implement start
    findRandomBooks();
  }

  Logger logger = Logger();

  listenToChanges() {
    notifyListeners();
  }

  final BookService _bookService = locator<BookService>();

  TextEditingController bookTitleController = TextEditingController();

  List<Book> randomBooks = [];

  findRandomBooks() async {
    randomBooks = await _bookService.findRandomBooks();
    notifyListeners();
  }

}