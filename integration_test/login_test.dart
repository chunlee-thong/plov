import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:plov/main.dart' as app;
import 'package:plov/src/core/controller/auth_controller.dart';
import 'package:plov/src/features/home/home_page.dart';
import 'package:plov/src/features/users/user_list_page.dart';
import 'package:provider/provider.dart';

import 'test_utils.dart';

void main() async {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('end-to-end test', () {
    testWidgets('Login and View Account Test', (tester) async {
      await app.main();
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(MaterialApp));

      final authController = context.read<AuthController>();

      if (!authController.loggedIn) {
        const emailKey = ValueKey("emailTC");
        const passwordKey = ValueKey("passwordTC");
        const buttonKey = ValueKey("btnLogin");

        ///Form validation
        await tester.findAndEnterText(emailKey, "");
        await tester.findAndEnterText(passwordKey, "");
        await tester.findAndTap(buttonKey);
        expect(find.text("Please input required field"), findsWidgets);

        await tester.findAndEnterText(emailKey, "123");
        await tester.findAndEnterText(passwordKey, "123");
        await tester.findAndTap(buttonKey);
        expect(find.text("This field required 5 characters long"), findsOneWidget);

        ///Authentication
        await tester.findAndEnterText(emailKey, "admin");
        await tester.findAndEnterText(passwordKey, "123456");
        await tester.findAndTap(buttonKey);
        expect(find.text("Incorrect email or password"), findsOneWidget);

        ///Success
        await tester.findAndEnterText(emailKey, "admin@email.com");
        await tester.findAndEnterText(passwordKey, "admin");
        await tester.findAndTap(buttonKey);
      }
      //
      expect(find.byType(HomePage), findsOneWidget);
      await tester.findTextAndTap("View accounts");
      expect(find.byType(UserListPage), findsOneWidget);
      await tester.findTextAndTap("000 100 200");
      final result = await tester.waitUntilFindThis(find.text("Personal Information"));
      expect(result, false);
    });
  });
}
