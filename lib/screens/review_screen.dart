import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final List<String> _categories = [
    'veggies',
    'fruits',
    'proteins',
    'carbs',
    'treats',
  ];
  final Map<String, List<String>> _categoryData = {};
  bool _isLoading = true;

  final Map<String, String> _labels = {
    'veggies': '🥦 Veggies',
    'fruits': '🍓 Fruits',
    'proteins': '🍗 Proteins',
    'carbs': '🍚 Carbs',
    'treats': '🍪 Treat',
  };

  final Map<String, int> _maxCounts = {
    'veggies': 5,
    'fruits': 4,
    'proteins': 3,
    'carbs': 2,
    'treats': 1,
  };

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    for (String cat in _categories) {
      final items = await _firestoreService.getCategoryItems(cat);
      _categoryData[cat] = items;
    }
    setState(() {
      _isLoading = false;
    });
  }

  Widget _buildCategorySection(String categoryID) {
    final label = _labels[categoryID] ?? categoryID;
    final items = _categoryData[categoryID] ?? [];
    final max = _maxCounts[categoryID] ?? 0;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label (${items.length}/$max)",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (items.isEmpty)
            const Text("No items selected.\n")
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: items.map((item) {
                return Chip(
                  label: Text(item),
                  backgroundColor: Colors.grey[200],
                  avatar: const Icon(Icons.check_circle, size: 16),
                );
              }).toList(),
            ),
          const Divider(),
        ],
      ),
    );
  }

  void _handleFinish() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("List saved! ✅")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your 54321 Grocery List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: "Jump to category",
            onPressed: () {
              // Optional: show dialog to jump to a category
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _categories.map(_buildCategorySection).toList(),
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _handleFinish,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text("Save & Finish"),
        ),
      ),
    );
  }
}
