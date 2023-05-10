import 'package:flutter/material.dart';
import 'package:plov/src/core/controller/auth_controller.dart';
import 'package:plov/src/core/router/router.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AuthController()),
      ],
      child: MaterialApp.router(
        routerConfig: goRouter,
        // routeInformationParser: goRouter.routeInformationParser,
        // backButtonDispatcher: goRouter.backButtonDispatcher,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(double.infinity, 42),
            ),
          ),
        ),
      ),
    );
  }
}
