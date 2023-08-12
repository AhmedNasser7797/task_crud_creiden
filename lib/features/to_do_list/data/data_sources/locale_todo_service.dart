import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_crud/core/hive_helper.dart';
import 'package:task_crud/features/to_do_list/data/models/todo_model.dart';

class LocaleTodoService {
  //Singleton
  LocaleTodoService._();

  static final LocaleTodoService instance = LocaleTodoService._();

  final HiveHelper _hiveHelper = HiveHelper.instance;
  late Box todoListBox;

  Future<void> saveTodo(TodoModel todo) async {
    await _hiveHelper.todoListBox.add(todo.toJson());
  }

  Future<void> deleteTodo(int index) async {
    await _hiveHelper.todoListBox.deleteAt(index);
  }

  Future<void> updateTodo(int index, TodoModel todo) async {
    await _hiveHelper.todoListBox.putAt(index, todo.toJson());
  }
}
