import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() {
  runApp(const RestartApp());
}

class RestartApp extends StatelessWidget {
  const RestartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}