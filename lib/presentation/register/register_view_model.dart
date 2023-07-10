import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:librarium/presentation/common/dialog/rules_dialog/show_register_rules_dialog.dart';
import 'package:logger/logger.dart';

import '../../core/route_manager.dart';
import '../../injection.dart';
import '../../model/user.dart';
import '../../service/authentication_service/authentication_service.dart';
import '../common/bottom_sheet/show_avatar_picker_bottom_sheet.dart';
import '../common/main_view_model.dart';
import '../common/snack_bar/show_snack_bar.dart';
import '../resources/string_manager.dart';

class RegisterViewModel extends MainViewModel {
  RegisterViewModel(super.context);

  @override
  void start() {
    // TODO: implement start
  }

  Logger logger = Logger();

  listenToChanges() {
    notifyListeners();
  }

  final regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}$');

  checkAll() {
    if (pickedImage == null) {
      return false;
    }
    if (usernameController.text.length < 8 || usernameController.text.length > 20) {
      return false;
    }
    if (!(regex.hasMatch(passwordController.text))) {
      return false;
    }
    if (!(regex.hasMatch(password2Controller.text))) {
      return false;
    }
    if (passwordController.text != password2Controller.text) {
      return false;
    }
    if (usernameController.text == passwordController.text) {
      return false;
    }
    if (usernameController.text == password2Controller.text) {
      return false;
    }
    if (firstNameController.text.length < 3 || firstNameController.text.length > 20) {
      return false;
    }
    if (usernameController.text == firstNameController.text) {
      return false;
    }
    if (lastNameController.text.length < 2 || lastNameController.text.length > 30) {
      return false;
    }
    if (genderController.text.length < 3 || genderController.text.length > 20) {
      return false;
    }
    if (aboutMeController.text.isEmpty) {
      return false;
    }
    return true;
  }

  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();

  showRegisterRules() {
    showRegisterRulesDialog(context);
  }

  final ImagePicker _picker = ImagePicker();

  bool obscureText = true;
  bool obscureText2 = true;

  changeObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }

  changeObscureText2() {
    obscureText2 = !obscureText2;
    notifyListeners();
  }

  selectImageMode() {
    showAvatarPickerBottomSheet(context, this);
  }

  XFile? pickedImage;

  useCamera() async {
    pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      notifyListeners();
      Navigator.pop(context);
    }
  }

  useGallery() async {
    pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      notifyListeners();
      Navigator.pop(context);
    }
    logger.i("Gallery used");
  }

  goLogin() {
    Navigator.pushReplacementNamed(context, AppRoute.loginRoute);
  }

  final User _user = User();
  bool savedUser = false;

  register() async {
    Uint8List? imageBytes = await pickedImage?.readAsBytes();

    _user
      ..avatar = imageBytes
      ..username = usernameController.text.trim()
      ..password = passwordController.text
      ..firstName = firstNameController.text.trim()
      ..lastName = lastNameController.text.toUpperCase().trim()
      ..gender = genderController.text.trim()
      ..aboutMe = aboutMeController.text.trim()
      ..wallet = 0.0;

    savedUser = await _authenticationService.register(_user);
    if (savedUser) {
      goLogin();
      showSnackBar(context, AppString.registerSuccessful);
    }
    else {
      showSnackBar(context, AppString.registerFailed);
    }
  }


}
