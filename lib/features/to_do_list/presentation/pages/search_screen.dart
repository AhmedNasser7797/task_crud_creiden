import 'package:flutter/material.dart';
import 'package:task_crud/core/extension_methods/size_extension.dart';
import 'package:task_crud/features/to_do_list/presentation/manager/todo_provider.dart';
import 'package:task_crud/features/to_do_list/presentation/pages/home_screen.dart';
import 'package:task_crud/features/to_do_list/presentation/pages/todo_details_sccreen.dart';
import 'package:task_crud/features/to_do_list/presentation/widgets/empty_todo_list_widget.dart';
import 'package:task_crud/features/to_do_list/presentation/widgets/todo_card.dart';

class SearchedScreen extends StatefulWidget {
  const SearchedScreen({Key? key}) : super(key: key);

  @override
  State<SearchedScreen> createState() => _SearchedScreenState();
}

class _SearchedScreenState extends State<SearchedScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GradiantScreen(
      child: Scaffold(
        endDrawer: const TodoDetailsScreen(),
        backgroundColor: Colors.transparent,
        key: scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text("Searched TODO"),
          backgroundColor: Colors.transparent,
        ),
        body: Consumer<TodoProvider>(builder: (context, value, child) {
          if (value.searchedItems.isEmpty) {
            return const EmptyTodoList(
              title: "No todo with this criteria",
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: value.searchedItems.length,
              separatorBuilder: (context, index) => 20.ph,
              itemBuilder: (context, index) => TODOCard(
                  todo: value.searchedItems[index], scaffoldKey: scaffoldKey),
            );
          }
        }),
      ),
    );
  }
}
