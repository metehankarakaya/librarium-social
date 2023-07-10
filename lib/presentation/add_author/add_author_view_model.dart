import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:librarium/model/author.dart';
import 'package:librarium/presentation/common/main_view_model.dart';
import 'package:librarium/service/author_service/author_service.dart';
import 'package:logger/logger.dart';

import '../../injection.dart';
import '../common/dialog/rules_dialog/show_add_author_rules_dialog.dart';
import '../common/snack_bar/show_snack_bar.dart';
import '../resources/string_manager.dart';

class AddAuthorViewModel extends MainViewModel {
  AddAuthorViewModel(super.context);

  @override
  void start() {
    // TODO: implement start
  }

  Logger logger = Logger();

  listenToChanges() {
    notifyListeners();
  }

  checkAll() {
    if (firstNameController.text.length < 3 || firstNameController.text.length > 20) {
      return false;
    }
    if (lastNameController.text.length < 2 || lastNameController.text.length > 30) {
      return false;
    }
    if (ageController.text.length < 2 || ageController.text.length > 3) {
      return false;
    }
    if (nationalityController.text.length < 2 || nationalityController.text.length > 30) {
      return false;
    }
    if (birthDateController.text.isEmpty) {
      return false;
    }
    return true;
  }

  final AuthorService _authorService = locator<AuthorService>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController deathDateController = TextEditingController();

  showAddBookRules() {
    showAddAuthorRulesDialog(context);
  }

  pickBirthDate() async {
    DateTime? birthDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1500),
      lastDate: DateTime.now()
    );
    if (birthDate != null) {
      birthDateController.text = DateFormat("dd-MM-yyyy").format(birthDate); //gg-aa-yyyy
      _author.birthDate = birthDate; //gg-aa-yyyy
      notifyListeners();
    }
  }

  pickDeathDate() async {
    DateTime? deathDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1500),
      lastDate: DateTime.now()
    );
    if (deathDate != null) {
      deathDateController.text = DateFormat("dd-MM-yyyy").format(deathDate); //gg-aa-yyyy
      _author.deathDate = deathDate; //gg-aa-yyyy
      notifyListeners();
    }
  }

  final Author _author = Author();
  bool savedAuthor = false;

  addAuthor() async {
    _author
      ..firstName = firstNameController.text.trim()
      ..lastName = lastNameController.text.toUpperCase().trim()
      ..age = int.tryParse(ageController.text)
      ..nationality = nationalityController.text.trim();

    savedAuthor = await _authorService.addAuthor(_author);

    if (savedAuthor) {
      showSnackBar(context, AppString.addAuthorSuccessful);
      clearForm();
    }
    else {
      showSnackBar(context, AppString.addAuthorFailed);
    }
  }

  clearForm() {
    firstNameController.text = "";
    lastNameController.text = "";
    ageController.text = "";
    nationalityController.text = "";
    birthDateController.text = "";
    deathDateController.text = "";
    notifyListeners();
  }


}