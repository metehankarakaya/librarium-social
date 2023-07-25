import 'package:flutter/material.dart';
import 'package:librarium/presentation/add_post/add_post_view_model.dart';
import 'package:stacked/stacked.dart';

import '../resources/color_manager.dart';
import '../resources/string_manager.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({Key? key}) : super(key: key);

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ViewModelBuilder<AddPostViewModel>.reactive(
      viewModelBuilder: () {
        AddPostViewModel viewModel = AddPostViewModel(context);
        viewModel.start();
        return viewModel;
      },
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: AppBar(
          backgroundColor: AppColor.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => viewModel.goBack(),
            splashRadius: 20,
            icon: Icon(Icons.close, color: AppColor.blue900,),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: size.width/4,
                child: ElevatedButton(
                  onPressed: viewModel.checkAll()
                    ? () => viewModel.addPost()
                    : null,
                  child: const Text(AppString.post),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowIndicator();
              return true;
            },
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: viewModel.user.avatar != null
                            ? MemoryImage(viewModel.user.avatar!)
                            : null,
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          trailing: Wrap(
                            spacing: 12.0,
                            children: [
                              SizedBox.square(
                                dimension: size.width/8,
                                child: OutlinedButton(
                                  onPressed: () => viewModel.useGallery(),
                                  child: const Icon(Icons.photo_library),
                                ),
                              ),
                              viewModel.pickedImage != null
                                ? SizedBox.square(
                                    dimension: size.width/8,
                                    child: OutlinedButton(
                                      onPressed: () => viewModel.removeImage(),
                                      child: const Icon(Icons.delete),
                                    ),
                                  )
                                : const SizedBox(),
                            ],
                          ),
                          title: Text(
                            "@${viewModel.user.username}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("${viewModel.user.firstName} ${viewModel.user.lastName}"),
                        ),
                      )
                    ],
                  ),
                ),
                TextFormField(
                  autofocus: true,
                  controller: viewModel.postContentController,
                  onChanged: (val) => viewModel.listenToChanges(),
                  maxLines: null,
                  maxLength: 2000,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    label: const Text(AppString.postContent),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.blue900
                      ),
                    )
                  ),
                ),
                viewModel.pickedImage != null
                  ? SizedBox(
                      width: size.width/2,
                      height: size.height/2,
                      child: Image.memory(viewModel.pickedImageBytes!)
                    )
                  : const SizedBox()
              ],
            ),
          )
        ),
      ),
    );
  }
}
