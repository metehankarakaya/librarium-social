import 'dart:typed_data';

import 'package:flutter/material.dart';

void zoomBookCoverImage(BuildContext context, Uint8List coverImage) {
  Size size = MediaQuery.sizeOf(context);
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      children: [
        Container(
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.memory(
              coverImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    )
  );
}
