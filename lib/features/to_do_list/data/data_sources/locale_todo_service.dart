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
    await _hiveHelper.todoListBox.put(todo.id, todo.toJson());
  }

  Future<void> deleteTodo(int key) async {
    await _hiveHelper.todoListBox.delete(key);
  }

  Future<void> updateTodo(TodoModel todo) async {
    await _hiveHelper.todoListBox.put(todo.id, todo.toJson());
  }

  Future<void> clearAll() async {
    await _hiveHelper.todoListBox.clear();
  }
}
