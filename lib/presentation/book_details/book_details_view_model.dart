import 'package:flutter/material.dart';
import 'package:librarium/injection.dart';
import 'package:librarium/model/book.dart';
import 'package:librarium/presentation/common/main_view_model.dart';
import 'package:librarium/service/book_service/book_service.dart';
import 'package:logger/logger.dart';

import '../common/dialog/zoom_book_cover_image_dialog.dart';

class BookDetailsViewModel extends MainViewModel {
  BookDetailsViewModel(super.context);

  @override
  void start() {
    // TODO: implement start
  }

  Logger logger = Logger();

  listenToChanges() {
    notifyListeners();
  }

  final BookService _bookService = locator<BookService>();

  TextEditingController titleController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController isbnController = TextEditingController();
  TextEditingController pageCountController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Book foundBook = Book();

  findBookDetails(String bookId) async {
    foundBook = await _bookService.findBookDetails(bookId);
    titleController.text = foundBook.title ?? "";
    languageController.text = foundBook.language ?? "";
    isbnController.text = foundBook.isbn ?? "";
    pageCountController.text = foundBook.pageCount.toString();
    priceController.text = "${foundBook.price} TL";
    descriptionController.text = foundBook.description ?? "";
    notifyListeners();
  }

  zoomImage() {
    zoomBookCoverImage(context, foundBook.coverImage!);
  }


}
