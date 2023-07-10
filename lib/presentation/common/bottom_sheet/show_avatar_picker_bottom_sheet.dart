import 'package:flutter/material.dart';

import '../../register/register_view_model.dart';
import '../../resources/color_manager.dart';
import '../../resources/string_manager.dart';

void showAvatarPickerBottomSheet(BuildContext context, RegisterViewModel viewModel) {
  Size size = MediaQuery.sizeOf(context);
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColor.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10)
      ),
    ),
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(7)
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera_alt_outlined),
                    title: const Text(AppString.camera),
                    onTap: () => viewModel.useCamera(),
                  ),
                  ListTile(
                    leading: const Icon(Icons.image_outlined),
                    title: const Text(AppString.gallery),
                    onTap: () => viewModel.useGallery(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            SizedBox(
              width: size.width,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)
                  )
                ),
                child: const Text(
                  AppString.cancel,
                  style: TextStyle(color: AppColor.red),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
