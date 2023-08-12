import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_crud/core/constants/vars.dart';
import 'package:task_crud/core/extension_methods/color_extension.dart';
import 'package:task_crud/core/extension_methods/size_extension.dart';
import 'package:task_crud/core/theme/theme_data.dart';
import 'package:task_crud/features/to_do_list/data/models/todo_model.dart';
import 'package:task_crud/features/to_do_list/presentation/manager/todo_provider.dart';

class TODOCard extends StatelessWidget {
  final TodoModel todo;
  const TODOCard({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    print("todo ${todo.color.toColor()}");
    return InkWell(
      onTap: () {
        context.read<TodoProvider>().selectTodo = todo;
        UtilsConstants().scaffoldKey.currentState?.openEndDrawer();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: cardColor(context),
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              offset: Offset(0, 1),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: todo.color.toColor(),
              radius: 10,
            ),
            16.pw,
            Expanded(
              child: Text(
                todo.name,
                style: titleStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            24.pw,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (todo.date != null)
                  Text(
                    "${todo.date!.day} ${DateFormat.MMM().format(todo.date!)}",
                    style: titleBlack(context),
                  ),
                6.ph,
                if (todo.time != null)
                  Text(
                    "${todo.time!.hour}:${todo.time!.minute}",
                    style: subtitleStyle(context)?.copyWith(fontSize: 10),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
