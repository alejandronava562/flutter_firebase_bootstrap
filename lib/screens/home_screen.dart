// User sees this if they are logged in

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/category_card.dart';
import '../screens/review_screen.dart';
import '../services/firestore_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

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
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  bool _isloading = true;

  final List<Map<String, dynamic>> _categories = [
    {'id': 'veggies', 'emoji': '🥦', 'label': 'Veggies', 'max': 5},
    {'id': 'fruits', 'emoji': '🍓', 'label': 'Fruits', 'max': 4},
    {'id': 'proteins', 'emoji': '🍗', 'label': 'Proteins', 'max': 3},
    {'id': 'carbs', 'emoji': '🍚', 'label': 'Carbs', 'max': 2},
    {'id': 'treats', 'emoji': '🍪', 'label': 'Treat', 'max': 1},
  ];

  final Map<String, int> _selectedCounts = {};

  @override
  void initState() {
    super.initState();
    _loadCategoryCounts();
  }

  Future<void> _loadCategoryCounts() async {
    for (var cat in _categories) {
      final id = cat['id'] as String;
      final items = await _firestoreService.getCategoryItems(id);
      _selectedCounts[id] = items.length;
    }
    setState(() {
      _isloading = false;
    });
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Sign out error $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('54321 Grocery Planner'),
        actions: [
          IconButton(
            onPressed: () => _signOut(context),
            icon: const Icon(Icons.logout),
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: _isloading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: _categories.map((cat) {
                  final id = cat['id'] as String;
                  return CategoryCard(
                    emoji: cat['emoji'] as String,
                    label: cat['label'] as String,
                    selectedCount: _selectedCounts[id] ?? 0,
                    maxCount: cat['max'] as int,
                    onTap: () async {
                      await Navigator.pushNamed(
                        context,
                        '/category',
                        arguments: {
                          'id': id,
                          'label': cat['label'],
                          'max': cat['max'],
                        },
                      );
                      _loadCategoryCounts();
                    },
                  );
                }).toList(),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/review');
        },
        label: const Text("Review List"),
        icon: const Icon(Icons.check),
      ),
    );
  }
}
