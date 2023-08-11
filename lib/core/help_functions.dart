import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_crud/core/theme/theme.dart';

import '/base/widgets/simple_textfield.dart';
import '/core/theme/theme_data.dart';

void navigateTo(
  Widget child,
  BuildContext context,
) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => child));
}

void navigateAndRemoveUntilTo(Widget child, BuildContext context,
        {bool rootNavigator = false}) async =>
    Navigator.of(context, rootNavigator: rootNavigator).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => child,
        ),
        (route) => false);

void navigateToAndReplacement(Widget child, BuildContext context) =>
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => child));

Future<void> showToast(
  String text,
) async {
  await Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: AppTheme.primary,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

RequiredRule requireRule() {
  return RequiredRule(validationMessage: "Required");
}

void showCustomDialog(BuildContext context, Widget child) => showDialog(
      context: context,
      builder: (context) => child,
    );

Size getSize(BuildContext context) => MediaQuery.of(context).size;

void error(Object? e, StackTrace? s, {String hint = ""}) {
  if (kDebugMode) {
    log(hint);
    log(e.toString());
    log(s.toString());
  }
}

void showErrorDialog(String title, BuildContext context,
        {bool isSuccess = false}) async =>
    showCustomDialog(
      context,
      AlertDialog(
        title: const Icon(
          Icons.error,
          color: Colors.red,
          size: 50,
        ),
        content: Text(
          title,
          style: titleStyle(context)?.copyWith(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Ok",
                style: titleStyle(context),
              ))
        ],
      ),
    );
