import 'package:hive_flutter/adapters.dart';

import 'constants/database_variable.dart';

class HiveHelper {
  HiveHelper._();
  static final HiveHelper instance = HiveHelper._();

  factory HiveHelper() => instance;
  late Box authBox;
  late Box themeBox;
  late Box todoListBox;
  final DatabaseVariables _variables = DatabaseVariables.instance;

  Future<void> init() async {
    await Hive.initFlutter();
    authBox = await Hive.openBox(_variables.authBox);
    themeBox = await Hive.openBox(_variables.themeBox);
    todoListBox = await Hive.openBox(_variables.todoListBox);
  }

  remove(String key) async {
    authBox.delete(key);
  }

  String? getStringFromAuth(String key) {
    return authBox.get(key);
  }

  Future<void> saveStringAboutAuth(String key, String value) async {
    authBox.put(key, value);
  }

  Future<void> saveAboutTheme(String key, bool value) async {
    themeBox.put(key, value);
  }

  bool getStringFromTheme(String key) {
    return themeBox.get(key) ?? false;
  }
}
