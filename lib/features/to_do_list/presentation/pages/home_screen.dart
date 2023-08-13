import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_crud/base/widgets/custom_button.dart';
import 'package:task_crud/base/widgets/login_simple_textfield.dart';
import 'package:task_crud/core/constants/vars.dart';
import 'package:task_crud/core/extension_methods/size_extension.dart';
import 'package:task_crud/core/hive_helper.dart';
import 'package:task_crud/features/to_do_list/data/models/todo_model.dart';
import 'package:task_crud/features/to_do_list/presentation/manager/todo_provider.dart';
import 'package:task_crud/features/to_do_list/presentation/pages/todo_details_sccreen.dart';
import 'package:task_crud/features/to_do_list/presentation/widgets/todo_card.dart';

import '../widgets/empty_todo_list_widget.dart';

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
            const Color(0x26FEA64C).withOpacity(0.9),
            const Color(0x66FE1E9A).withOpacity(0.9),
            const Color(0x66254DDE).withOpacity(0.9),
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
          actions: [
            IconButton(
              onPressed: addNewTask,
              icon: Image.asset(
                "assets/images/menu.png",
              ),
            ),
          ],
        ),
        endDrawer: const TodoDetailsScreen(),
        body: ValueListenableBuilder(
            valueListenable: HiveHelper.instance.todoListBox.listenable(),
            builder: (context, Box box, widget) {
              if (box.isEmpty) {
                return const EmptyTodoList();
              } else {
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: box.length,
                  separatorBuilder: (context, index) => 20.ph,
                  itemBuilder: (context, index) {
                    Map<dynamic, dynamic> todoData =
                        HiveHelper.instance.todoListBox.getAt(index);
                    if (todoData.isEmpty) {
                      return const SizedBox();
                    } else {
                      try {
                        TodoModel todo = TodoModel.fromJson(todoData);
                        todo.id = index;
                        return TODOCard(todo: todo);
                      } catch (e, s) {
                        error(e, s);
                        return const SizedBox();
                      }
                    }
                  },
                );
              }
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: addNewTask,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                shape: BoxShape.circle, gradient: buildGradientButton()),
            child: const Icon(
              Icons.add,
            ),
          ),
        ),
      ),
    );
  }

  void addNewTask() {
    ///delete selected item to add new one
    context.read<TodoProvider>().selectTodo = null;
    UtilsConstants().scaffoldKey.currentState?.openEndDrawer();
  }
}
