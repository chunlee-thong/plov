import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterExtension on WidgetTester {
  Future findAndTap(Key key) async {
    Finder finder = find.byKey(key);
    await tap(finder);
    await pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
  }

  Future findTypeAndTap(Type type) async {
    Finder finder = find.byType(type);
    await tap(finder);
    await pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
  }

  Future findTextAndTap(String text) async {
    Finder finder = find.text(text);
    await tap(finder);
    await pump();
    await Future.delayed(const Duration(seconds: 1));
  }

  Future findAndTapSmallDelay(Key key) async {
    Finder finder = find.byKey(key);
    await tap(finder);
    await pumpAndSettle();
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future delayed() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future findAndEnterText(Key key, String text) async {
    Finder finder = find.byKey(key);
    await enterText(finder, text);
    await pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<bool> waitUntilFindThis(Finder finder, {int delay = 5000}) async {
    await pump();
    await Future.delayed(Duration(milliseconds: delay));
    return finder.evaluate().isNotEmpty;
  }
}
