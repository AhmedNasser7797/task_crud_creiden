import 'package:flutter/material.dart';
import 'package:task_crud/core/hive_helper.dart';
import 'package:task_crud/core/notification_controller.dart';
import 'package:task_crud/features/to_do_list/data/models/todo_model.dart';
import 'package:task_crud/features/to_do_list/data/repositories/base_todo_repository.dart';

export 'package:provider/provider.dart';

class TodoProvider with ChangeNotifier {
  final BaseTodoRepository _baseTodoRepository = BaseTodoRepository.instance;
  List<TodoModel> items = [];
  TodoModel? selectedTodo;

  set selectTodo(TodoModel? value) {
    selectedTodo = value;

    notifyListeners();
  }

  void getTodos() {
    for (var element in HiveHelper.instance.todoListBox.values) {
      TodoModel todo = TodoModel.fromJson(element);
      items.add(todo);
    }
    if (items.isNotEmpty) {
      notifyListeners();
    }
  }

  int get newId {
    return items.length + 1;
  }

  Future<void> saveTodo(TodoModel todo) async {
    todo.id = newId;
    await _baseTodoRepository.saveTodo(todo);
    items.add(todo);
    notifyListeners();
    await NotificationController().createScheduleNotification(todo);
  }

  Future<void> deleteTodo() async {
    await _baseTodoRepository.deleteTodo(selectedTodo?.id ?? 0);
    items.remove(selectedTodo);
    notifyListeners();
    await NotificationController()
        .disableScheduledNotification(selectedTodo?.id ?? 0);

    selectedTodo = null;
  }

  Future<void> updateTodo() async {
    await _baseTodoRepository.updateTodo(selectedTodo!);

    ///update item in list
    items[items.indexWhere((element) => element.id == selectedTodo!.id)] =
        selectedTodo!;

    await NotificationController()
        .disableScheduledNotification(selectedTodo?.id ?? 0);
    await NotificationController().createScheduleNotification(selectedTodo!);
  }

  Future<void> clearAll() async {
    await _baseTodoRepository.clearAll();
    items.clear();
    notifyListeners();
  }
}
