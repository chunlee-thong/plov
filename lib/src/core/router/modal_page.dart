import 'package:flutter/material.dart';

class DialogPage<T> extends Page<T> {
  final Widget child;

  const DialogPage({required this.child, super.key});

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute<T>(
        context: context,
        settings: this,
        builder: (context) => child,
      );
}

class BottomSheetPage<T> extends Page<T> {
  final Widget child;

  const BottomSheetPage({required this.child, super.key});

  @override
  Route<T> createRoute(BuildContext context) => ModalBottomSheetRoute<T>(
        isScrollControlled: false,
        settings: this,
        builder: (context) => child,
      );
}
