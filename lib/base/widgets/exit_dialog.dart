import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/theme_data.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text(
        "Exit?",
        // CodegenLoader.exit.tr(),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            "No",
            style: titleStyle(context)?.copyWith(
              fontSize: 12,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else if (Platform.isIOS) {
              exit(0);
            }
          },
          child: Text(
            "Yes",
            style:
                titleStyle(context)?.copyWith(fontSize: 12, color: Colors.red),
          ),
        ),
      ],
    );
  }
}
