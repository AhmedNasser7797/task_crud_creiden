import 'package:flutter/material.dart';
import 'package:task_crud/core/constants/vars.dart';
import 'package:task_crud/core/extension_methods/size_extension.dart';
import 'package:task_crud/features/to_do_list/presentation/widgets/custom_drawer.dart';
import 'package:task_crud/features/to_do_list/presentation/widgets/todo_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,
            Color(0x26FEA64C).withOpacity(0.9),
            Color(0x66FE1E9A).withOpacity(0.9),
            Color(0x66254DDE).withOpacity(0.9),
          ],
          stops: const [0.2, 0.5, 0.9, 1],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: UtilsConstants().scaffoldKey,
        appBar: AppBar(
          title: const Text("TODO"),
          backgroundColor: Colors.transparent,
        ),
        drawer: const CustomDrawer(),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: 5,
          separatorBuilder: (context, index) => 20.ph,
          itemBuilder: (context, index) => const TODOCard(),
        ),
      ),
    );
  }
}
