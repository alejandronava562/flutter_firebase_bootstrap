// Grid layout that can be reused for each category

import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String emoji;
  final String label;
  final int selectedCount;
  final int maxCount;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.emoji,
    required this.label,
    required this.selectedCount,
    required this.maxCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 32)),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text('$selectedCount / $maxCount selected'),
            ],
          ),
        ),
      ),
    );
  }
}
