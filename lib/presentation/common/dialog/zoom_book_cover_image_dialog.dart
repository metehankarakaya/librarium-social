import 'dart:typed_data';

import 'package:flutter/material.dart';

void zoomBookCoverImage(BuildContext context, Uint8List coverImage) {
  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return SimpleDialog(
          children: [
            InteractiveViewer(
              maxScale: 5.0,
              child: Image.memory(
                coverImage,
                fit: BoxFit.contain,
              ),
            ),
          ],
        );
      },
    )
  );
}
