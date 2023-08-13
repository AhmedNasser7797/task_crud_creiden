import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:task_crud/core/hive_helper.dart';
import 'package:task_crud/core/notification_controller.dart';
import 'package:task_crud/features/to_do_list/data/models/todo_model.dart';
import 'package:task_crud/features/to_do_list/data/repositories/base_todo_repository.dart';

export 'package:provider/provider.dart';

class TodoProvider with ChangeNotifier {
  final BaseTodoRepository _baseTodoRepository = BaseTodoRepository.instance;
  List<TodoModel> items = [];
  List<TodoModel> get searchedItems => items.where((element) {
        return element.color == searchedColor?.hex ||
            (searchedDate != null &&
                DateTime(element.date!.year, element.date!.month,
                            element.date!.day)
                        .compareTo(DateTime(searchedDate!.year,
                            searchedDate!.month, searchedDate!.day)) ==
                    0);
      }).toList();
  TodoModel? selectedTodo;

  Color? searchedColor;
  DateTime? searchedDate;

  set selectTodo(TodoModel? value) {
    selectedTodo = value;

    notifyListeners();
  }

  set setSearchedColor(Color? color) {
    searchedColor = color;

    notifyListeners();
  }

  set setSearchedDate(DateTime? date) {
    searchedDate = date;

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
    await _baseTodoRepository.deleteTodo(selectedTodo!.id);
    items.remove(selectedTodo);
    notifyListeners();
    await NotificationController()
        .disableScheduledNotification(selectedTodo!.id);

    selectedTodo = null;
  }

  Future<void> updateTodo() async {
    await _baseTodoRepository.updateTodo(selectedTodo!);

    ///update item in list
    items[items.indexWhere((element) => element.id == selectedTodo!.id)] =
        selectedTodo!;

    await NotificationController()
        .disableScheduledNotification(selectedTodo!.id);
    await NotificationController().createScheduleNotification(selectedTodo!);
  }

  Future<void> clearAll() async {
    await _baseTodoRepository.clearAll();
    items.clear();
    notifyListeners();
  }
}
