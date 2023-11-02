import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:plov/src/core/controller/auth_controller.dart';
import 'package:plov/src/core/router/router.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late BuildContext materialContext;

  void initQuickAction() {}

  @override
  void initState() {
    Future.microtask(() => initQuickAction());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MultiProvider(
        providers: [
          Provider(create: (context) => AuthController()),
        ],
        child: MaterialApp.router(
          routerConfig: goRouter,
          // routeInformationParser: goRouter.routeInformationParser,
          // backButtonDispatcher: goRouter.backButtonDispatcher,
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            materialContext = context;
            return child!;
          },
          theme: ThemeData(
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
            ),
            fontFamily: GoogleFonts.lato().fontFamily,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(double.infinity, 42),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
