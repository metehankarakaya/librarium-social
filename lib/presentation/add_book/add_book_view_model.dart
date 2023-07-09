import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../injection.dart';
import '../../model/author.dart';
import '../../model/book.dart';
import '../../service/author_service/author_service.dart';
import '../../service/book_service/book_service.dart';
import '../common/dialog/selectAuthorDialog.dart';
import '../common/dialog/zoomBookCoverImageDialog.dart';
import '../common/main_view_model.dart';
import '../common/snack_bar/show_snack_bar.dart';
import '../resources/string_manager.dart';

class AddBookViewModel extends MainViewModel {
  AddBookViewModel(super.context);

  @override
  void start() {
    // TODO: implement start
    findAllAuthors();
  }

  Logger logger = Logger();

  imChanging() {
    notifyListeners();
  }

  checkAll() {
    if (coverImage == null) {
      return false;
    }
    if (titleController.text.length < 2 || titleController.text.length > 100) {
      return false;
    }
    if (languageController.text.length < 3 || languageController.text.length > 50) {
      return false;
    }
    if (isbnController.text.length != 13) {
      return false;
    }
    if (pageCountController.text.isEmpty || pageCountController.text.length > 6) {
      return false;
    }
    if (priceController.text.isEmpty || priceController.text.length > 8) {
      return false;
    }
    if (descriptionController.text.isEmpty) {
      return false;
    }
    if (selectedAuthor == null) {
      return false;
    }
    return true;
  }

  final BookService _bookService = locator<BookService>();
  final AuthorService _authorService = locator<AuthorService>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController isbnController = TextEditingController();
  TextEditingController pageCountController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  XFile? coverImage;
  Uint8List? coverImageBytes;

  useGallery() async {
    coverImage = await _picker.pickImage(source: ImageSource.gallery);
    if (coverImage != null) {
      coverImageBytes = await coverImage!.readAsBytes();
      notifyListeners();
    }
    logger.i("Gallery used");
  }

  zoomImage() {
    zoomBookCoverImage(context, coverImageBytes!);
  }

  removeImage() {
    coverImage = null;
    notifyListeners();
  }

  List<Author> authorList = [];
  List<Author> filteredAuthorList = [];

  findAllAuthors() async {
    authorList = await _authorService.findAllAuthors();
    filteredAuthorList = authorList;
    notifyListeners();
  }

  void filterAuthorList(String val) {
    if (val.isEmpty) {
      filteredAuthorList = authorList;
      notifyListeners();
    }
    else {
      filteredAuthorList = authorList
          .where(
              (element) =>
          element.firstName!.toLowerCase().contains(val.toLowerCase()) ||
              element.lastName!.toLowerCase().contains(val.toLowerCase())
      ).toList();
      notifyListeners();
    }
  }

  Author? selectedAuthor;

  showSelectAuthorDialog() {
    selectAuthorDialog(context, this);
  }

  selectAuthor(Author? val) {
    selectedAuthor = val!;
    notifyListeners();
    Navigator.pop(context);
  }

  Book book = Book();
  bool savedBook = false;

  saveBook() async {
    book
      ..title = titleController.text.trim()
      ..description = descriptionController.text.trim()
      ..language = languageController.text.trim()
      ..isbn = isbnController.text.trim()
      ..pageCount = int.tryParse(pageCountController.text.trim())
      ..coverImage = coverImageBytes
      ..author = selectedAuthor
      ..price = double.tryParse(priceController.text.trim());
    notifyListeners();
    logger.w(book.toJson());
    savedBook = await _bookService.saveBook(book);
    if (savedBook) {
      showSnackBar(context, AppString.saveBookSuccessful);
      clearForm();
    }
    else {
      showSnackBar(context, AppString.saveBookFailed);
    }
  }

  clearForm() {
    coverImage = null;
    titleController.text = "";
    languageController.text = "";
    isbnController.text = "";
    pageCountController.text = "";
    priceController.text = "";
    descriptionController.text = "";
    notifyListeners();
  }

}
