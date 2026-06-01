import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reset_app/auth_wrapper.dart';

import 'login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home: AuthWrapper(),
    );
  }
}