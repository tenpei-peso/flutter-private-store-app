import 'package:flutter/material.dart';

//自由に使える
showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  required ValueChanged<bool> onConfirmed
}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => confirmDialog(
          title: title,
          content: content,
          onConfirmed: onConfirmed
      ) //confirmDialog
  ); //showDialog
}

class confirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final ValueChanged<bool> onConfirmed;

  const confirmDialog({required this.title, required this.content, required this.onConfirmed}) ;

  @override

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: () {
              onConfirmed(true);
              Navigator.pop(context);
            },
            child: Text("はい"),
        ),
        TextButton(
          onPressed: () {
            onConfirmed(false);
            Navigator.pop(context);
          },
          child: Text("いいえ"),
        ),
      ],
    );
  }
}
