// User sees this if they are logged in

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../widgets/category_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Sign out using Firebase
  Future<void> _signout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Authgate will detect and redirect
    } catch (e) {
      // Exception handling
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Sign out error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final categories = [
      {'id': 'veggies', 'emoji': '🥦', 'label': 'Veggies', 'selected': 2, 'max': 5},
      {'id': 'fruits',  'emoji': '🍓', 'label': 'Fruits',  'selected': 1, 'max': 4},
      {'id': 'proteins','emoji': '🍗', 'label': 'Proteins','selected': 0, 'max': 3},
      {'id': 'carbs',   'emoji': '🍚', 'label': 'Carbs',   'selected': 1, 'max': 2},
      {'id': 'treats',  'emoji': '🍪', 'label': 'Treats',  'selected': 0, 'max': 1},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('54321 Grocery Planner')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2, // two cards per row
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: categories.map((cat) {
            return CategoryCard(
              emoji: cat['emoji'] as String,
              label: cat['label'] as String,
              selectedCount: cat['selected'] as int,
              maxCount: cat['max'] as int,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/category',
                  arguments: {
                    'id': cat['id'],
                    'label': cat['label'],
                    'max': cat['max'],
                  },
                );
              },
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Push to ReviewList screen later
        },
        label: const Text("Review List"),
        icon: const Icon(Icons.check),
      ),
    );
  }
}
