import 'package:flutter/material.dart';
import 'package:plov/src/core/router/router.dart';
import 'package:skadi/skadi.dart';

class NonAuthPage extends StatelessWidget {
  const NonAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Not authenticated",
              style: kTs24,
            ),
            ElevatedButton(
              onPressed: goRouter.pop,
              child: const Text("Go back"),
            ),
          ],
        ),
      ),
    );
  }
}
