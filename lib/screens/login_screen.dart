import 'package:flutter/material.dart';
import '../auth/auth_service.dart';

class LoginScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await _authService.signInAnonymously();
              // Once signed in, AuthGate will automatically redirect
            } catch (e) {
              print("Anon login error: $e");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to sign in anonymously')),
              );
            }
          },
          child: const Text("Continue as Guest"),
        ),
      ),
    );
  }
}
