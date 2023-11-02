import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:plov/src/core/controller/auth_controller.dart';

import 'app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  if (kIsWeb) {
    usePathUrlStrategy();
  }
  await AuthController.init();
  runApp(const MyApp());
}
