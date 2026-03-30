import 'package:flutter/material.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({
    super.key,
    required this.category,
    required this.color,
    required this.items,
    });

  final String category;
  final Color color;
  final List<Widget> items;

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  Color get color => widget.color;
  String get category => widget.category;
  List<Widget> get items => widget.items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Text(
                    category,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1),
            ...items,
          ],
        ),
      ),
    );;
  }
}