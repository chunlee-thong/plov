import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oktoast/oktoast.dart';
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

class _LoginPageState extends State<LoginPage> with SkadiFormMixin, DeferDispose {
  late TextEditingController emailTC = createDefer(() => TextEditingController());
  late TextEditingController passwordTC = createDefer(() => TextEditingController());

  //

  @override
  Widget build(BuildContext context) {
    return KeyboardDismiss(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                LoadingOverlayProvider.toggle(true);
                await SkadiUtils.wait();
                await context.read<AuthController>().login("admin@email.com", "admin");
                LoadingOverlayProvider.toggle(false);
                goRouter.go(RoutePath.home);
                print("Done");
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: Center(
          child: Card(
            child: SizedBox(
              width: 400,
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        key: const ValueKey("emailTC"),
                        controller: emailTC,
                        decoration: inputDecor("Email", Icons.email),
                        validator: SkadiFormValidator.validateField,
                      ),
                      const SpaceY(),
                      TextFormField(
                        key: const ValueKey("passwordTC"),
                        controller: passwordTC,
                        decoration: inputDecor("Password", Icons.lock),
                        validator: (value) => SkadiFormValidator.validateField(value, length: 5),
                        obscureText: true,
                      ),
                      SkadiAsyncButton(
                        key: const ValueKey("btnLogin"),
                        onPressed: () async {
                          if (isFormValidated) {
                            try {
                              await SkadiUtils.wait(3000);
                              await context.read<AuthController>().login(
                                    emailTC.text.trim(),
                                    passwordTC.text.trim(),
                                  );
                              goRouter.go(RoutePath.home);
                            } catch (ex) {
                              showToast(ex.toString());
                            }
                          }
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
        ),
      ),
    );
  }
}
