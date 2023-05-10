class RoutePath {
  static const String home = "/";
  static const String accounts = "account";

  ///Non auth
  static const String login = "/login";
  static const String register = "/register";
  static const String forgetPassword = "/forget-password";
}

final nonAuthPaths = [
  RoutePath.login,
  RoutePath.register,
  RoutePath.forgetPassword,
];
