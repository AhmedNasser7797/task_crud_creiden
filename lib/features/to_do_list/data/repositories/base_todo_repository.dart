import 'package:task_crud/features/to_do_list/data/data_sources/locale_todo_service.dart';
import 'package:task_crud/features/to_do_list/data/models/todo_model.dart';

class BaseTodoRepository {
  //Singleton
  BaseTodoRepository._();

  static final BaseTodoRepository instance = BaseTodoRepository._();
  final LocaleTodoService _localeTodoService = LocaleTodoService.instance;
  Future<void> saveTodo(TodoModel todo) async {
    await _localeTodoService.saveTodo(todo);
  }

  Future<void> deleteTodo(int key) async {
    await _localeTodoService.deleteTodo(key);
  }

  Future<void> updateTodo(TodoModel todo) async {
    await _localeTodoService.updateTodo(todo);
  }

  Future<void> clearAll() async {
    await _localeTodoService.clearAll();
  }
}
