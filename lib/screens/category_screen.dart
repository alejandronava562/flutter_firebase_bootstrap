import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late String categoryLabel;
  late int maxItems;
  final List<String> items = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    categoryLabel = args['label'] ?? 'Unknown';
    maxItems = args['max'] ?? 5;
  }

  void _addItem() {
    final text = _controller.text.trim();
    if (text.isEmpty || items.length >= maxItems) return;

    setState(() {
      items.add(text);
      _controller.clear();
    });
  }

  void _removeItem(String item) {
    setState(() {
      items.remove(item);
    });
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
