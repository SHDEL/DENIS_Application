import 'package:flutter/material.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({
    super.key,
    required this.category,
    required this.icon,
    required this.color,
    required this.items,
    });

  final String category;
  final IconData icon;
  final Color color;
  final List<Widget> items;

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  get color => widget.color;
  
  IconData? get icon => null;
  
  String? get category => null;
  
  get items => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: color.withOpacity(0.15),
              child: Row(
                children: [
                  Icon(icon, size: 18, color: color),
                  const SizedBox(width: 8),
                  Text(
                    category!,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
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