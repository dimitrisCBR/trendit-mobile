import 'package:flutter/material.dart';
import 'package:trendit/src/ui/styles/text_styles.dart';

Future<void> showAppDialog(
    BuildContext context, String title, String message, Function callback) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: googleFontStyle(Theme.of(context).textTheme.titleLarge),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                message,
                style:  googleFontStyle(Theme.of(context).textTheme.bodyMedium),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'OK',
                style: googleFontStyle(Theme
                    .of(context)
                    .textTheme
                    .labelLarge),
            ),
            onPressed: () {
              callback();
              Navigator.pop(context, 'OK');
            },
          ),
        ],
      );
    },
  );
}

Future<void> showAppDialogWithTwoActions(BuildContext context, String title, String message,
    String cancelButton, String okButton, Function cancelCallback, Function actionCallback) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
            style:  googleFontStyle(Theme.of(context).textTheme.titleLarge),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                message,
                style:  googleFontStyle(Theme.of(context).textTheme.bodyMedium),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              cancelButton,
              style:  googleFontStyle(Theme.of(context).textTheme.labelLarge),
            ),
            onPressed: () {
              cancelCallback();
              Navigator.pop(context, cancelButton);
            },
          ),
          TextButton(
            child: Text(
              okButton,
              style:  googleFontStyle(Theme.of(context).textTheme.labelLarge),
            ),
            onPressed: () {
              actionCallback();
              Navigator.pop(context, okButton);
            },
          ),
        ],
      );
    },
  );
}
