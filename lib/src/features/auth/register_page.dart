import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final String? email;
  const RegisterPage({super.key, this.email});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
    );
  }
}
