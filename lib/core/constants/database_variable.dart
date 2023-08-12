class DatabaseVariables {
  DatabaseVariables._();
  static final DatabaseVariables instance = DatabaseVariables._();
  factory DatabaseVariables() => instance;

  String authBox = 'auth';
  String themeBox = 'theme';
  String todoListBox = 'todoListBox';
  String token = 'token';

  String userId = 'id';
}
