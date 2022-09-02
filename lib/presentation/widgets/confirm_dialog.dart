import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  const ConfirmDialog({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        // The "Yes" button
        TextButton(
            onPressed: () {
              Navigator.of(context).pop('Yes');
            },
            child: const Text('Yes')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop('No');
            },
            child: const Text('No'))
      ],
    );
  }
}
