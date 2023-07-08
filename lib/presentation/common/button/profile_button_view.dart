import 'package:flutter/material.dart';

class ProfileButtonView extends StatelessWidget {
  final String content;
  final String count;
  final VoidCallback onPressed;

  const ProfileButtonView({
    Key? key,
    required this.content,
    required this.count,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return OutlinedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(content),
            SizedBox(height: size.height/64,),
            Text(count)
          ],
        ),
      ),
    );
  }
}
