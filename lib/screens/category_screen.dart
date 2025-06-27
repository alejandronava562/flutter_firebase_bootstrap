import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late String categoryLabel;
  late int maxItems;
  late String categoryID;
  final FirestoreService _firestoreService = FirestoreService();
  final List<String> items = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    categoryID = args['id'] ?? 'unknown';
    categoryLabel = args['label'] ?? 'Unknown';
    maxItems = args['max'] ?? 5;

    _loadItems();
  }

  Future<void> _loadItems() async {
    final loadedItems = await _firestoreService.getCategoryItems(categoryID);
    setState(() {
      items.clear();
      items.addAll(loadedItems);
    });
  }

  void _addItem() async {
    final text = _controller.text.trim();
    if (text.isEmpty || items.length >= maxItems) return;

    setState(() {
      items.add(text);
      _controller.clear();
    });

    // Firestore saving
    await _firestoreService.saveCategoryItems(categoryID, items);
  }

  void _removeItem(String item) async {
    setState(() {
      items.remove(item);
    });

    // Firestore saving
    await _firestoreService.saveCategoryItems(categoryID, items);
  }

  @override
  Widget build(BuildContext context) {
    final count = items.length;

    return Scaffold(
      appBar: AppBar(title: Text('$categoryLabel ($count / $maxItems)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type a grocery item...",
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: count >= maxItems ? null : _addItem,
                  child: const Text("Add"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // List of items
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text(item),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeItem(item),
                    ),
                  );
                },
              ),
            ),
            if (count >= maxItems)
              const Text(
                "Max items reached! Remove one to add more.",
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
