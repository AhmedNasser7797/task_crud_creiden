import 'package:flutter/material.dart';
import 'package:task_crud/core/help_functions.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: getSize(context).width * 0.8,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.white, Color(0x80CAEBFE)],
            stops: [0.1, 0.9],
          ),
        ),
      ),
    );
  }
}
