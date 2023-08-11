class ServerConstants {
  ServerConstants._();

  static final ServerConstants instance = ServerConstants._();

  factory ServerConstants() => instance;

  static const String site =
      "https://phpstack-561490-3524079.cloudwaysapps.com/api-start-point/public/";
  static String apiBase = "${site}api/";

  /// Auth
  String loginEndPoint = "auth/login";
}
