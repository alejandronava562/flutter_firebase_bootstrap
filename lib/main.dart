// Entry point of the program

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_app/screens/category_screen.dart';
import 'firebase_options.dart.';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '54321 Grocery Planner',
      theme: ThemeData(primarySwatch: Colors.green),
      home: AuthGate(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/category': (context) => const CategoryScreen(),
      },
    );
    }
  }