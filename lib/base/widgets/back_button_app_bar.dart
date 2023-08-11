import 'package:flutter/material.dart';

class BackButtonAppBar extends StatelessWidget {
  final VoidCallback? onTap;
  const BackButtonAppBar({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap ?? () => Navigator.pop(context),
      icon: Icon(
        Icons.arrow_back_ios_sharp,
        color: Theme.of(context).appBarTheme.iconTheme?.color,
      ),
    );
  }
}
