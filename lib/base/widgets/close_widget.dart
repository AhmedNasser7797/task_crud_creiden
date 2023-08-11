import 'package:flutter/material.dart';

class CloseWidget extends StatelessWidget {
  const CloseWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Icons.close,
        color: Colors.black,
      ),
    );
  }
}
