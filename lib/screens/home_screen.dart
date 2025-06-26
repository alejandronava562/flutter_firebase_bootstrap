// User sees this if they are logged in

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Sign out using Firebase
  Future<void> _signout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Authgate will detect and redirect
    } catch (e) {
      // Exception handling
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Sign out error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('54321 Grocery Planner'),
        actions: [
          IconButton(
            onPressed: () => _signout(context),
            tooltip: 'Sign Out',
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(child: Text('Welcome! You are logged in.')),
    );
  }
}
