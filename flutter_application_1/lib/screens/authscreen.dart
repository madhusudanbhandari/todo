import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/authform.dart';

class Authscreen extends StatefulWidget {
  const Authscreen({super.key});

  @override
  State<Authscreen> createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Authentication'), centerTitle: true),
      body: const AuthForm(),
    );
  }
}
