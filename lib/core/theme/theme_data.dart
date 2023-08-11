import 'package:flutter/material.dart';

TextStyle? titleStyle(BuildContext context) =>
    Theme.of(context).textTheme.bodyLarge;

TextStyle? subtitleStyle(BuildContext context) =>
    Theme.of(context).textTheme.bodyMedium;

TextStyle? textFieldTitle(BuildContext context) =>
    Theme.of(context).textTheme.bodySmall;

TextStyle? appbarTitle(BuildContext context) =>
    Theme.of(context).textTheme.displayLarge;

TextStyle? textFieldLoginTitle(BuildContext context) =>
    Theme.of(context).textTheme.displayMedium;

TextStyle? buttonStyle(BuildContext context) =>
    Theme.of(context).textTheme.headlineLarge;

Color primaryColor(BuildContext context) => Theme.of(context).primaryColor;

Color dividerColor(BuildContext context) => Theme.of(context).dividerColor;

Color cardColor(BuildContext context) => Theme.of(context).cardColor;
