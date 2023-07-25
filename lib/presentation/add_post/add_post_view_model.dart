import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:librarium/model/post.dart';
import 'package:librarium/model/user.dart';
import 'package:librarium/presentation/common/main_view_model.dart';
import 'package:librarium/presentation/common/snack_bar/show_snack_bar.dart';
import 'package:librarium/presentation/resources/string_manager.dart';
import 'package:librarium/service/post_service/post_service.dart';
import 'package:librarium/service/user_service/user_service.dart';
import 'package:logger/logger.dart';

import '../../injection.dart';

class AddPostViewModel extends MainViewModel {
  AddPostViewModel(super.context);

  @override
  void start() {
    // TODO: implement start
    getAvatar();
  }

  Logger logger = Logger();

  listenToChanges() {
    notifyListeners();
  }

  checkAll() {
    if (postContentController.text.isEmpty && pickedImage == null) {
      return false;
    }
    return true;
  }

  final UserService _userService = locator<UserService>();
  final PostService _postService = locator<PostService>();

  TextEditingController titleController = TextEditingController();
  TextEditingController postContentController = TextEditingController();

  goBack() {
    Navigator.pop(context);
  }

  final ImagePicker _picker = ImagePicker();
  XFile? pickedImage;
  Uint8List? pickedImageBytes;
  useGallery() async {
    pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      pickedImageBytes = await pickedImage!.readAsBytes();
      notifyListeners();
    }
    logger.i("Gallery used");
  }

  removeImage() {
    pickedImage = null;
    pickedImageBytes = null;
    notifyListeners();
  }

  User user = User();

  getAvatar() async {
    user = await _userService.findUserDetail();
    notifyListeners();
  }

  final Post _post = Post();
  bool addedPost = false;

  addPost() async {
    //_post.title = titleController.text.trim();
    _post.content = postContentController.text.trim();
    _post.image = pickedImageBytes;
    notifyListeners();
    addedPost = await _postService.addPost(_post);
    if (addedPost) {
      showSnackBar(context, AppString.addPostSuccessful);
      clearForm();
    }
    else {
      showSnackBar(context, AppString.addPostFailed);
    }
  }

  clearForm() {
    titleController.clear();
    postContentController.clear();
    pickedImage = null;
    notifyListeners();
  }

}
