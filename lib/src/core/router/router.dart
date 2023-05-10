import 'package:go_router/go_router.dart';
import 'package:plov/src/core/controller/auth_controller.dart';
import 'package:plov/src/core/router/path.dart';
import 'package:plov/src/features/auth/forget_password_page.dart';
import 'package:plov/src/features/auth/login_page.dart';
import 'package:plov/src/features/auth/register_page.dart';
import 'package:plov/src/features/home/home_page.dart';
import 'package:plov/src/features/users/user_list_page.dart';
import 'package:provider/provider.dart';

final goRouter = GoRouter(
  initialLocation: "/login",
  routes: [
    //Non auth
    GoRoute(
      path: RoutePath.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: RoutePath.register,
      builder: (context, state) {
        var email = state.extra.toString();
        return RegisterPage(email: email);
      },
    ),

    GoRoute(
      path: RoutePath.forgetPassword,
      builder: (context, state) => const ForgetPasswordPage(),
    ),

    ///Auth
    GoRoute(
      path: RoutePath.home,
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: RoutePath.accounts,
          builder: (context, state) => const UserListPage(),
          routes: [
            GoRoute(
              path: ":accId",
              pageBuilder: (context, state) {
                String? accountNumber = state.pathParameters['accId'];
                String? type = state.queryParameters['type'];
                return NoTransitionPage(
                  child: UserListPage(
                    accountNumber: accountNumber,
                    type: type,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
  redirect: (context, state) {
    final auth = context.read<AuthController>();
    final path = state.location;
    if (auth.loggedIn) {
      if (nonAuthPaths.contains(path)) {
        return RoutePath.home;
      }
    } else {
      if (!nonAuthPaths.contains(path)) {
        return RoutePath.login;
      }
    }
    return null;
  },
);
