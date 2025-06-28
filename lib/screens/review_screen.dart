import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class ReviewScreen extends StatefulWidget{
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  
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

  Widget _buildCategorySection(String categoryID) {
    final label = _labels[categoryID] ?? categoryID;

    return Padding(padding: const EdgeInsets.all(12), );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}