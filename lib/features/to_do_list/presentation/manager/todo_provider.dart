import 'package:flutter/material.dart';
import 'package:task_crud/core/notification_controller.dart';
import 'package:task_crud/features/to_do_list/data/models/todo_model.dart';
import 'package:task_crud/features/to_do_list/data/repositories/base_todo_repository.dart';

export 'package:provider/provider.dart';

class TodoProvider with ChangeNotifier {
  final BaseTodoRepository _baseTodoRepository = BaseTodoRepository.instance;
  TodoModel? selectedTodo;

  set selectTodo(TodoModel? value) {
    selectedTodo = value;

    notifyListeners();
  }

  Future<void> saveTodo(TodoModel todo) async {
    await _baseTodoRepository.saveTodo(todo);
    await NotificationController().createScheduleNotification(todo);
  }

  Future<void> deleteTodo() async {
    await _baseTodoRepository.deleteTodo(selectedTodo?.id ?? 0);
    await NotificationController()
        .disableScheduledNotification(selectedTodo?.id ?? 0);

    selectedTodo = null;
  }

  Future<void> updateTodo() async {
    await _baseTodoRepository.updateTodo(selectedTodo?.id ?? 0, selectedTodo!);
    await NotificationController()
        .disableScheduledNotification(selectedTodo?.id ?? 0);
    await NotificationController().createScheduleNotification(selectedTodo!);
  }
}
