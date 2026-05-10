import 'package:flutter/material.dart';

void showBaseInfoDialog(BuildContext context, String title) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Ок'),
        ),
      ],
    ),
  );
}