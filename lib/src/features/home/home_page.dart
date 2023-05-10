import 'package:flutter/material.dart';
import 'package:plov/src/core/controller/auth_controller.dart';
import 'package:plov/src/core/router/path.dart';
import 'package:plov/src/core/router/router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<AuthController>().logout();
              goRouter.go(RoutePath.login);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            goRouter.push("/${RoutePath.accounts}");
          },
          child: const Text("View accounts"),
        ),
      ),
    );
  }
}
