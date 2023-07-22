import 'dart:typed_data';

import 'package:flutter/material.dart';

void fullAvatarDialog(BuildContext context, Uint8List avatar) {
  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return SimpleDialog(
          children: [
            InteractiveViewer(
              maxScale: 5.0,
              child: Image.memory(
                avatar,
                fit: BoxFit.contain,
              ),
            ),
          ],
        );
      },
    )
  );
}
