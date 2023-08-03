import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final Widget? content;
  final Widget? title;

  const CustomAlertDialog({Key? key, this.content, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28.0),
        ),
      ),
      title: title,
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("OK"),
        )
      ],
    );
  }
}
