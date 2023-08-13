import 'package:flutter/material.dart';
import 'package:task_crud/core/extension_methods/size_extension.dart';
import 'package:task_crud/core/theme/theme_data.dart';

class EmptyTodoList extends StatelessWidget {
  const EmptyTodoList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error,
            size: 34,
          ),
          8.ph,
          Text(
            'No todo list now',
            style: titleStyle(context)?.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
