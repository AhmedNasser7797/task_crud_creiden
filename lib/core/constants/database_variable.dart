class DatabaseVariables {
  DatabaseVariables._();
  static final DatabaseVariables instance = DatabaseVariables._();
  factory DatabaseVariables() => instance;

  String token = 'token';
  String authBox = 'auth';
  String themeBox = 'theme';
  String userId = 'id';
}
