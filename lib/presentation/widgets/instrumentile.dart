import 'package:denis/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

class InstrumentTile extends StatefulWidget {
  const InstrumentTile({super.key, required this.name, required this.location, this.onTap});
  final String name;
  final String location;
  final VoidCallback? onTap;
  @override
  State<InstrumentTile> createState() => _InstrumentTileState();
}

class _InstrumentTileState extends State<InstrumentTile> {
  String get name => widget.name;
  String get location => widget.location;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTap ?? () {}, // ให้คลิกได้
      dense: true,
      title: Text(
        name,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          location,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}