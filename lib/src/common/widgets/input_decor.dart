import 'package:flutter/material.dart';

InputDecoration inputDecor(String label, IconData icon) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon),
  );
}
