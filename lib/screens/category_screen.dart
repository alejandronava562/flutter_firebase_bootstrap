import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget{
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
    // TODO: implement build
    throw UnimplementedError();
  }
}