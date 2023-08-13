import 'package:flutter/material.dart';
import 'package:task_crud/base/widgets/custom_button.dart';
import 'package:task_crud/base/widgets/loading_widget.dart';
import 'package:task_crud/base/widgets/login_simple_textfield.dart';
import 'package:task_crud/base/widgets/simple_textfield.dart';
import 'package:task_crud/core/extension_methods/size_extension.dart';
import 'package:task_crud/features/to_do_list/presentation/manager/todo_provider.dart';
import 'package:task_crud/features/to_do_list/presentation/pages/todo_details_sccreen.dart';
import 'package:task_crud/features/to_do_list/presentation/widgets/filter_dialog.dart';
import 'package:task_crud/features/to_do_list/presentation/widgets/todo_card.dart';

import '../widgets/empty_todo_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });
    super.initState();
  }

  void getData() {
    try {
      LoadingScreen.show(context);
      context.read<TodoProvider>().getTodos();
      Navigator.pop(context);
    } catch (e, s) {
      error(e, s);
      showToast(e.toString());
    }
  }

  void showFilterDialog() {
    showDialog(context: context, builder: (context) => const FilterDialog());
  }

  @override
  Widget build(BuildContext context) {
    return GradiantScreen(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text("TODO"),
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: showFilterDialog,
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              )),
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
        body: Consumer<TodoProvider>(builder: (context, value, child) {
          if (value.items.isEmpty) {
            return const EmptyTodoList();
          } else {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: value.items.length,
              separatorBuilder: (context, index) => 20.ph,
              itemBuilder: (context, index) =>
                  TODOCard(todo: value.items[index], scaffoldKey: scaffoldKey),
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
    scaffoldKey.currentState?.openEndDrawer();
  }
}

class GradiantScreen extends StatelessWidget {
  final Widget child;
  const GradiantScreen({Key? key, required this.child}) : super(key: key);

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
      child: child,
    );
  }
}
