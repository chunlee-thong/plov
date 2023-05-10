import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:plov/src/core/controller/auth_controller.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    usePathUrlStrategy();
  }
  await AuthController.init();
  runApp(const MyApp());
}
