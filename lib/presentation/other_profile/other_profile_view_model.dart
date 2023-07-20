import 'package:librarium/model/common_model/other_user.dart';
import 'package:librarium/presentation/common/main_view_model.dart';
import 'package:librarium/presentation/common/snack_bar/show_snack_bar.dart';
import 'package:logger/logger.dart';

import '../../core/route_manager.dart';
import '../../injection.dart';
import '../../model/book.dart';
import '../../model/quote.dart';
import '../../model/user.dart';
import '../../service/book_service/book_service.dart';
import '../../service/quote_service/quote_service.dart';
import '../../service/user_service/user_service.dart';
import '../common/dialog/profile_dialog/added_books_dialog.dart';
import '../common/dialog/profile_dialog/followers_dialog.dart';
import '../common/dialog/profile_dialog/followings_dialog.dart';
import '../common/dialog/profile_dialog/quotes_dialog.dart';

class OtherProfileViewModel extends MainViewModel {
  OtherProfileViewModel(super.context);

  @override
  void start() {
    // TODO: implement start
  }

  Logger logger = Logger();

  listenToChanges() {
    notifyListeners();
  }

  final UserService _userService = locator<UserService>();
  final BookService _bookService = locator<BookService>();
  final QuoteService _quoteService = locator<QuoteService>();

  bool? isFollow = false;
  bool checkFollowers() {
    isFollow = otherUser.followers?.contains(otherUser.visitorId);
    notifyListeners();
    return isFollow!;
  }

  followOtherUser(String otherUserId) async {
    bool isFollowBool = false;
    isFollowBool = await _userService.followOtherUser(otherUserId);
    if (isFollowBool) {
      findOtherUserDetail(otherUserId);
      showSnackBar(context, "Takip edildi.");
    }
    else {
      showSnackBar(context, "Takip edilemedi.");
    }
  }

  unFollowOtherUser(String otherUserId) async {
    bool isUnFollowBool = false;
    isUnFollowBool = await _userService.unfollowOtherUser(otherUserId);
    if (isUnFollowBool) {
      findOtherUserDetail(otherUserId);
      showSnackBar(context, "Takipten çıkarıldı.");
    }
    else {
      showSnackBar(context, "Takipten çıkarılamadı.");
    }
  }

  OtherUser otherUser = OtherUser();

  findOtherUserDetail(String otherUserId) async {
    otherUser = await _userService.findOtherUserDetail(otherUserId);
    notifyListeners();
    checkFollowers();
  }

  List<Quote> foundQuotes = [];
  List<Quote> filteredFoundQuotes = [];
  showQuotesDialog() async {
    foundQuotes = await _quoteService.findQuotesByUserId(otherUser.id ?? "");
    filteredFoundQuotes = foundQuotes;
    notifyListeners();
    quotesDialog(context, viewModel: this);
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
    foundBooks = await _bookService.findBooksByUserId(otherUser.id ?? "");
    filteredFoundBooks = foundBooks;
    notifyListeners();
    addedBooksDialog(context, viewModel: this);
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
    foundFollowings = await _userService.findFollowingsByUserId(otherUser.id ?? "");
    filteredFoundFollowings = foundFollowings;
    notifyListeners();
    followingsDialog(context, viewModel: this);
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
    foundFollowers = await _userService.findFollowersByUserId(otherUser.id ?? "");
    filteredFoundFollowers = foundFollowers;
    notifyListeners();
    followersDialog(context, viewModel: this);
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

  goOtherProfile({String otherUserId = ""}) async {
    navigateOtherUserProfileWithParam(context, otherUserId);
  }

}
