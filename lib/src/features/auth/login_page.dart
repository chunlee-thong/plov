import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plov/src/common/widgets/input_decor.dart';
import 'package:plov/src/core/controller/auth_controller.dart';
import 'package:plov/src/core/router/path.dart';
import 'package:plov/src/core/router/router.dart';
import 'package:provider/provider.dart';
import 'package:skadi/skadi.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: SizedBox(
            width: 400,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(
                    Icons.verified_user,
                    size: 64,
                    color: Colors.green,
                  ),
                  const SpaceY(24),
                  TextFormField(
                    decoration: inputDecor("Email", Icons.email),
                  ),
                  const SpaceY(),
                  TextFormField(
                    decoration: inputDecor("Password", Icons.lock),
                    obscureText: true,
                  ),
                  SkadiAsyncButton(
                    onPressed: () async {
                      await context.read<AuthController>().login();
                      goRouter.go(RoutePath.home);
                    },
                    child: const Text("Login"),
                  ),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).push(RoutePath.forgetPassword);
                    },
                    child: const Text("Forget password"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Doesn't have an account?"),
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).push(RoutePath.register);
                        },
                        child: const Text("Register"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
