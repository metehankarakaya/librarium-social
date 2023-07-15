import 'package:flutter/material.dart';
import 'package:librarium/core/route_manager.dart';
import 'package:librarium/model/book.dart';
import 'package:librarium/model/common_model/edit_about_me.dart';
import 'package:librarium/model/quote.dart';
import 'package:librarium/presentation/common/dialog/profile_dialog/edit_about_me_dialog.dart';
import 'package:librarium/service/book_service/book_service.dart';
import 'package:librarium/service/quote_service/quote_service.dart';
import 'package:logger/logger.dart';

import '../../injection.dart';
import '../../model/user.dart';
import '../../service/user_service/user_service.dart';
import '../common/dialog/profile_dialog/added_books_dialog.dart';
import '../common/dialog/profile_dialog/followers_dialog.dart';
import '../common/dialog/profile_dialog/followings_dialog.dart';
import '../common/dialog/profile_dialog/quotes_dialog.dart';
import '../common/main_view_model.dart';
import '../common/snack_bar/show_snack_bar.dart';
import '../resources/string_manager.dart';

class ProfileViewModel extends MainViewModel {
  ProfileViewModel(super.context);

  @override
  void start() {
    // TODO: implement start
    findUserDetail();
  }

  Logger logger = Logger();

  listenToChanges() {
    notifyListeners();
  }

  final UserService _userService = locator<UserService>();
  final BookService _bookService = locator<BookService>();
  final QuoteService _quoteService = locator<QuoteService>();

  TextEditingController aboutMeController = TextEditingController();

  User user = User();

  findUserDetail() async {
    user = await _userService.findUserDetail();
    aboutMeController.text = user.aboutMe ?? "";
    notifyListeners();
  }

  goSettingView() {
    Navigator.pushNamed(context, AppRoute.settingsRoute);
  }

  List<Quote> foundQuotes = [];
  List<Quote> filteredFoundQuotes = [];
  showQuotesDialog() async {
    foundQuotes = await _quoteService.findQuotesByUserId(user.id ?? "");
    filteredFoundQuotes = foundQuotes;
    notifyListeners();
    quotesDialog(context, this);
  }

  void filterFoundQuotes(String value) {
    if (value.isEmpty) {
      filteredFoundQuotes = foundQuotes;
      notifyListeners();
    }
    else {
      filteredFoundQuotes = foundQuotes
        .where(
          (element) =>
          element.content!.toLowerCase().contains(value.toLowerCase())).toList();
      notifyListeners();
    }
  }

  List<Book> foundBooks = [];
  List<Book> filteredFoundBooks = [];
  showAddedBooksDialog() async {
    foundBooks = await _bookService.findBooksByUserId(user.id ?? "");
    filteredFoundBooks = foundBooks;
    notifyListeners();
    addedBooksDialog(context, this);
  }

  void filterFoundBooks(String value) {
    if (value.isEmpty) {
      filteredFoundBooks = foundBooks;
      notifyListeners();
    }
    else {
      filteredFoundBooks = foundBooks
        .where(
        (element) =>
          element.title!.toLowerCase().contains(value.toLowerCase())).toList();
      notifyListeners();
    }
  }

  List<User> foundFollowings = [];
  List<User> filteredFoundFollowings = [];
  showFollowingsDialog() async {
    foundFollowings = await _userService.findFollowingsByUserId(user.id ?? "");
    filteredFoundFollowings = foundFollowings;
    notifyListeners();
    followingsDialog(context, this);
  }

  void filterFoundFollowings(String value) {
    if (value.isEmpty) {
      filteredFoundFollowings = foundFollowings;
      notifyListeners();
    }
    else {
      filteredFoundFollowings = foundFollowings
        .where(
          (element) =>
            element.username!.toLowerCase().contains(value.toLowerCase()) ||
            element.firstName!.toLowerCase().contains(value.toLowerCase()) ||
            element.lastName!.toLowerCase().contains(value.toLowerCase())).toList();
      notifyListeners();
    }
  }

  List<User> foundFollowers = [];
  List<User> filteredFoundFollowers = [];
  showFollowersDialog() async {
    foundFollowers = await _userService.findFollowersByUserId(user.id ?? "");
    filteredFoundFollowers = foundFollowers;
    notifyListeners();
    followersDialog(context, this);
  }

  void filterFoundFollowers(String value) {
    if (value.isEmpty) {
      filteredFoundFollowers = foundFollowers;
      notifyListeners();
    }
    else {
      filteredFoundFollowers = foundFollowers
        .where(
          (element) =>
          element.username!.toLowerCase().contains(value.toLowerCase()) ||
          element.firstName!.toLowerCase().contains(value.toLowerCase()) ||
          element.lastName!.toLowerCase().contains(value.toLowerCase())).toList();
      notifyListeners();
    }
  }

  bool aboutMeBool = false;

  goBack() {
    Navigator.pop(context);
  }

  showEditAboutMeDialog() { //deprecated
    editAboutMeDialog(context, this);
  }

  bool readOnlyBool = true;

  changeReadOnly() { //'showEditAboutMeDialog' alternative
    readOnlyBool = !readOnlyBool;
    notifyListeners();
  }

  editAboutMe() async {
    EditAboutMe editAboutMe = EditAboutMe();
    editAboutMe.aboutMe = aboutMeController.text;
    notifyListeners();
    aboutMeBool = await _userService.editAboutMe(editAboutMe);
    if (aboutMeBool) {
      findUserDetail();
      changeReadOnly(); //if you want to use 'showEditAboutMeDialog', goBack(); this part
      showSnackBar(context, AppString.editAboutMeSuccessful);
    }
    else {
      goBack();
      showSnackBar(context, AppString.editAboutMeFailed);
    }

  }

}
